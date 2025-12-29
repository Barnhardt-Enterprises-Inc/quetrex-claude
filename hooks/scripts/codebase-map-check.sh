#!/bin/bash
# Codebase map check hook
# Reminds to check .claude/codebase-map.md before searching

CODEBASE_MAP="${CLAUDE_PROJECT_DIR:-.}/.claude/codebase-map.md"
SEARCH_COUNTER="${CLAUDE_PROJECT_DIR:-.}/.claude/session/search_count"

# Ensure directory exists
mkdir -p "$(dirname "$SEARCH_COUNTER")" 2>/dev/null

# Read current count or start at 0
if [ -f "$SEARCH_COUNTER" ]; then
  COUNT=$(cat "$SEARCH_COUNTER")
else
  COUNT=0
fi

# Increment counter
COUNT=$((COUNT + 1))
echo "$COUNT" > "$SEARCH_COUNTER"

# First search of the session - remind about codebase map
if [ "$COUNT" -eq 1 ]; then
  if [ -f "$CODEBASE_MAP" ]; then
    cat <<EOF

---
**CODEBASE MAP EXISTS**: Before searching, check \`.claude/codebase-map.md\`

The codebase map may already contain the information you need.
Read it first to avoid unnecessary searching.

\`\`\`
Read: .claude/codebase-map.md
\`\`\`
---

EOF
  else
    cat <<EOF

---
**CODEBASE MAP MISSING**: Consider creating \`.claude/codebase-map.md\`

After this search, document the codebase structure to avoid
repeated exploration in future sessions.
---

EOF
  fi
fi

exit 0
