#!/usr/bin/env python3
"""Exercise two real ZLE sessions with isolated history (no third-party Python deps).

Optionally set ZSH_HISTORY_TEST_INIT to an autosuggestions plugin or a full .zshrc
for integration coverage. The test never reads or writes the user's history.
"""
import os
import pathlib
import pty
import select
import shlex
import shutil
import signal
import tempfile
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]


def read_output(fd, timeout=0.3):
    output = b""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if select.select([fd], [], [], 0.02)[0]:
            output += os.read(fd, 65536)
    return output


def send(fd, text):
    os.write(fd, text.encode())
    return read_output(fd)


with tempfile.TemporaryDirectory(prefix="zsh-history-test-") as directory:
    tmp = pathlib.Path(directory)
    init = os.environ.get("ZSH_HISTORY_TEST_INIT")
    setup = f"source {shlex.quote(init)}\n" if init else ""
    history_source = shlex.quote(str(ROOT / "src/zsh_history.sh"))
    (tmp / ".zshrc").write_text(
        setup
        + f"source {history_source}\n"
        + f"source {shlex.quote(str(ROOT / 'src/peco.sh'))}\n"
        + 'HISTFILE="$HOME/.zsh_history"\nHISTSIZE=1000\nSAVEHIST=1000\n'
        + "PROMPT='TEST> '\nRPROMPT=''\nMAC_OS=false\n"
        + 'peco() { cat > "$ZDOTDIR/captured"; }\n'
        + 'tac() { cat; }\n'
        + 'capture-buffer() { print -r -- "$BUFFER" > "$ZDOTDIR/buffer"; }\n'
        + "zle -N capture-buffer\nbindkey '^X^B' capture-buffer\n"
    )
    sessions = []
    try:
        for _ in range(2):
            pid, fd = pty.fork()
            if pid == 0:
                os.environ.update(HOME=directory, ZDOTDIR=directory, TERM="xterm-256color")
                os.execv(shutil.which("zsh"), ["zsh", "-d", "-i"])
            sessions.append((pid, fd))
            startup = read_output(fd, 2)
            assert b"TEST>" in startup, startup
        a, b = [fd for _, fd in sessions]
        send(a, "print -r -- TAB_A_FIRST_7319\n")
        assert "TAB_A_FIRST_7319" in (tmp / ".zsh_history").read_text()
        send(b, "\x12")
        assert "TAB_A_FIRST_7319" in (tmp / "captured").read_text()
        print("PASS: Ctrl-R imports from an idle prompt")

        send(a, "print -r -- TAB_A_SECOND_7319\n")
        send(b, "\x1b[A\x18\x02")
        assert (tmp / "buffer").read_text().strip() == "print -r -- TAB_A_SECOND_7319"
        send(b, "\x15")
        print("PASS: first Up imports from an idle prompt")

        if init:
            send(a, "print -r -- UNIQUE_SUGGESTION_7319\n")
            output = send(b, "print -r -- UNIQUE_")
            output += read_output(b, 1)
            assert b"SUGGESTION_7319" in output, output
            send(b, "\x15")
            print("PASS: autosuggestion sees another tab's new command")

        send(b, f"setopt INC_APPEND_HISTORY_TIME; source {history_source}; source {history_source}\n")
        output = send(b, 'print -r -- "OPTIONS:$options[sharehistory]:$options[incappendhistory]:$options[incappendhistorytime]"\n')
        assert b"OPTIONS:on:off:off" in output, output
        send(a, "print -r -- TAB_A_RELOAD_7319\n")
        send(b, "\x1b[A\x18\x02")
        assert (tmp / "buffer").read_text().strip() == "print -r -- TAB_A_RELOAD_7319", (tmp / "buffer").read_text()
        send(b, "\x15")
        print("PASS: repeated reload and conflicting option cleanup")
    finally:
        for pid, fd in sessions:
            os.kill(pid, signal.SIGHUP)
            os.close(fd)
            os.waitpid(pid, 0)
