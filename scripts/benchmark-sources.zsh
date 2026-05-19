#!/usr/bin/env zsh
# Benchmark each `source` line referenced from kentrino.zsh.
#
# For every `source "$DIRECTORY/src/<file>.sh"` entry we spawn a fresh zsh,
# load just that file, and record:
#   - elapsed wall-clock time (ms)
#   - exit status
#   - combined stdout/stderr (truncated, single line)
#
# Output is a Markdown table written to $1 (default: ./bench-result.md).

set -u

zmodload zsh/datetime

ROOT="${0:A:h:h}"
KENTRINO="$ROOT/kentrino.zsh"
OUT="${1:-$ROOT/bench-result.md}"

if [[ ! -f "$KENTRINO" ]]; then
  print -u2 "kentrino.zsh not found at $KENTRINO"
  exit 1
fi

# Header. Surrounding `<!-- ... -->` makes it easy to identify the comment.
{
  print -- "<!-- source-benchmark -->"
  print -- "## kentrino.zsh source benchmark"
  print --
  print -- "Each \`source\` line in \`kentrino.zsh\` was loaded individually in a fresh \`zsh\` on \`${RUNNER_OS:-$(uname -s)} ${RUNNER_ARCH:-$(uname -m)}\`."
  print --
  print -- "| # | Source | Time (ms) | Exit | Output |"
  print -- "|---:|---|---:|---:|---|"
} > "$OUT"

# Collect source paths in declaration order.
typeset -a sources
while IFS= read -r line; do
  rel="${line#source \"\$DIRECTORY/}"
  rel="${rel%\"}"
  sources+=("$rel")
done < <(grep -E '^source "\$DIRECTORY/[^"]+"' "$KENTRINO")

if (( ${#sources[@]} == 0 )); then
  print -u2 "No source lines found in $KENTRINO"
  exit 1
fi

total_ms=0
idx=0
for rel in "${sources[@]}"; do
  idx=$(( idx + 1 ))
  full="$ROOT/$rel"
  tmp_out=$(mktemp)

  if [[ ! -f "$full" ]]; then
    elapsed_fmt="-"
    exit_code="missing"
    output_cell="_(file not found)_"
  else
    start=$EPOCHREALTIME
    zsh -c "DIRECTORY=\"$ROOT\"; source \"$full\"" > "$tmp_out" 2>&1
    exit_code=$?
    end=$EPOCHREALTIME

    elapsed_ms=$(( (end - start) * 1000 ))
    elapsed_fmt=$(printf "%.1f" "$elapsed_ms")
    total_ms=$(( total_ms + elapsed_ms ))

    raw=$(< "$tmp_out")
    if [[ -z "$raw" ]]; then
      output_cell="_(empty)_"
    else
      oneline=$(printf '%s' "$raw" | tr '\n' ' ' | tr -s ' ')
      truncated=$(printf '%s' "$oneline" | cut -c1-200)
      if (( ${#oneline} > 200 )); then
        truncated="${truncated}…"
      fi
      escaped=$(printf '%s' "$truncated" | sed 's/|/\\|/g; s/`/\x27/g')
      output_cell="\`${escaped}\`"
    fi
  fi

  printf '| %d | `%s` | %s | %s | %s |\n' \
    "$idx" "$rel" "$elapsed_fmt" "$exit_code" "$output_cell" >> "$OUT"

  rm -f "$tmp_out"
done

total_fmt=$(printf "%.1f" "$total_ms")
{
  print --
  print -- "**Total: ${total_fmt} ms across ${#sources[@]} sources** (sequential, fresh shell per source)."
} >> "$OUT"
