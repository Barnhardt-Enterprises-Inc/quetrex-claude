#!/bin/bash
# Checkpoint reminder hook
# Tracks tool calls and reminds to checkpoint every 10 calls

COUNTER_FILE="${CLAUDE_PROJECT_DIR:-.}/.claude/session/tool_count"

# Ensure directory exists
mkdir -p "$(dirname "$COUNTER_FILE")" 2>/dev/null

# Read current count or start at 0
if [ -f "$COUNTER_FILE" ]; then
  COUNT=$(cat "$COUNTER_FILE")
else
  COUNT=0
fi

# Increment counter
COUNT=$((COUNT + 1))
echo "$COUNT" > "$COUNTER_FILE"

# Check if reminder is needed (every 10 tool calls)
if [ $((COUNT % 10)) -eq 0 ]; then
  cat <<EOF

---
**CHECKPOINT REMINDER**: You have made $COUNT tool calls since last checkpoint.

Save your progress NOW to prevent work loss:
\`\`\`
context_save(key: "current-task", value: "<what you're doing>", category: "progress", priority: "high")
context_checkpoint(name: "auto-checkpoint-$COUNT", description: "<current state>")
\`\`\`

Or run: /checkpoint
---

EOF
fi

exit 0
