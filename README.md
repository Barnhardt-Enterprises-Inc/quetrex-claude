# Quetrex for Claude Code

**A production-grade Claude Code plugin that transforms Claude from a coding assistant into an autonomous development system.**

Created by Glen Barnhardt with the help of Claude Code

---

## What is Quetrex?

Quetrex solves the fundamental problems with using Claude Code at scale:

| Problem | Quetrex Solution |
|---------|------------------|
| **Token burn from grep searches** | Semantic search via Serena |
| **Context loss between sessions** | Mandatory memory-keeper checkpoints |
| **Inconsistent code quality** | Strict TypeScript enforcement + lint hooks |
| **Dangerous git operations** | Branch protection + worktree isolation |
| **Claude ignoring instructions** | Enforcement hooks + agent routing |
| **Repetitive codebase exploration** | LSP-powered symbol intelligence via Serena |

## Core Philosophy

> "If you find a bug, document and fix it" - never say "that error was not part of current changes."

Quetrex enforces a **zero-tolerance policy** for:
- TypeScript `any` types
- Uncommitted work on main branch
- Modifying tests to make them pass
- Ignoring errors "not in scope"
- Raw grep searches that burn tokens

---

## Key Features

### Serena - LSP-Powered Code Intelligence

**No more repetitive grep searches.** Quetrex uses Serena for token-efficient code navigation via Language Server Protocol (LSP).

**Why Serena?**
- Understands code structure (not just text)
- 30+ language support via LSP
- Returns only relevant symbols, not entire files
- No external database required

```
# Find symbols by name
mcp__serena__find_symbol(name_path_pattern: "UserService", include_body: true)

# Find who uses a symbol
mcp__serena__find_referencing_symbols(name_path: "handleAuth", relative_path: "src/auth.ts")

# Pattern search across codebase
mcp__serena__search_for_pattern(substring_pattern: "authentication")

# Get file structure overview
mcp__serena__get_symbols_overview(relative_path: "src/services/user.ts")

# Symbol-level editing
mcp__serena__replace_symbol_body(name_path: "getUser", relative_path: "...", body: "...")
mcp__serena__rename_symbol(name_path: "oldName", relative_path: "...", new_name: "newName")
```

### Multi-Agent Orchestration

Eight specialized agents with defined responsibilities:

| Agent | Role | Can Write Code? |
|-------|------|-----------------|
| **Orchestrator** | Coordinates all work | NO |
| **Designer** | UI/UX prototypes | NO |
| **Architect** | Technical specs | NO |
| **Developer** | Implementation | YES |
| **Test-Runner** | Execute tests | NO (read-only) |
| **QA-Fixer** | Fix failing tests | YES (not tests) |
| **Reviewer** | Code review | NO (read-only) |
| **Security** | Security audit | NO |

### Persistent Memory

Never lose work. Quetrex requires checkpointing every 5-10 tool calls:

```
context_save(key: "current-task", value: "implementing auth", priority: "high")
context_checkpoint(name: "auth-progress", description: "JWT middleware complete")
```

### Enforcement Hooks

| Hook | Trigger | Action |
|------|---------|--------|
| `enforce-branch.sh` | Bash commands | Block main branch commits |
| `typecheck.sh` | After file edits | Run `tsc --noEmit` |
| `lint.sh` | After file edits | Run `biome check` |
| `config-guard.sh` | Config file edits | Warn/block changes |
| `test-guard.sh` | Test file edits | Block modifications |
| `semantic-search-reminder.sh` | Grep/Glob usage | Suggest Claude Context |
| `checkpoint-reminder.sh` | Every 10 tools | Remind to checkpoint |

---

## Installation

### Via Plugin Marketplace (Recommended)

```bash
# Inside Claude Code
/plugin marketplace add barnent1/quetrex-claude
```

### Manual Installation

```bash
git clone https://github.com/barnent1/quetrex-claude.git
claude --plugin-dir ./quetrex-claude
```

### Required Environment Variables

```bash
# For GitHub integration
export GITHUB_TOKEN="ghp_..."
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize project with Quetrex standards |
| `/plan <feature>` | Design + architecture with human approval |
| `/build <issue>` | Autonomous implementation from spec |
| `/fix [target]` | Fix failing tests or errors |
| `/spawn <agent>` | Spawn agent in WezTerm tab |
| `/status` | Check session and agent status |
| `/ship [issue]` | Create PR with final checks |
| `/checkpoint` | Manual memory checkpoint |
| `/recover` | Restore from previous session |

---

## Tech Stack (Enforced)

| Layer | Technology | NOT Allowed |
|-------|------------|-------------|
| Framework | Next.js 15 (App Router) | Pages Router |
| Language | TypeScript (strict) | `any` type |
| Styling | Tailwind CSS + ShadCN | CSS modules |
| Animation | Framer Motion | - |
| Server State | TanStack Query | Raw fetch |
| Client State | Zustand | Redux, Context |
| Database | PostgreSQL + Drizzle | Prisma |
| Cache | Upstash Redis | - |
| Package Manager | pnpm | npm, yarn |
| Testing | Vitest + Playwright | Jest |
| Linting | Biome | ESLint |

---

## MCP Servers

Quetrex bundles three MCP servers:

| Server | Purpose |
|--------|---------|
| **serena** | LSP-powered code intelligence (30+ languages) |
| **memory-keeper** | Persistent context across sessions |
| **github** | Issue/PR automation |

### Serena Capabilities

| Tool | Purpose |
|------|---------|
| `find_symbol` | Find functions, classes, variables by name |
| `find_referencing_symbols` | Who uses this symbol? (impact analysis) |
| `search_for_pattern` | Regex search across codebase |
| `get_symbols_overview` | File structure at a glance |
| `replace_symbol_body` | Edit symbol definitions |
| `rename_symbol` | Codebase-wide rename refactoring |
| `list_dir` / `find_file` | Navigate project structure |
| `write_memory` / `read_memory` | Persist project knowledge |

---

## Workflow Example

### 1. Plan the Feature

```bash
/plan add user authentication with JWT
```

- Designer creates UI mockups
- Architect writes technical spec
- **Human approves before any code is written**

### 2. Build Autonomously

```bash
/build 42  # GitHub issue number
```

- Creates worktree: `../worktrees/feature-42-auth`
- Developer implements from spec
- Test-runner validates continuously
- QA-fixer resolves failures (max 10 attempts)
- Reviewer performs final quality gate

### 3. Ship to Production

```bash
/ship 42
```

- Security audit
- Final test run
- Creates PR via `gh pr create`

---

## WezTerm Integration

Quetrex integrates with WezTerm for visual agent management:

- Each agent gets a color-coded tab
- Orchestrator: Blue
- Developer: Green
- Test-Runner: Yellow
- QA-Fixer: Red
- Security: Orange

Commands:
- `/create-term-project` - Set up project colors
- `/change-term-tab-color` - Change current tab

---

## Why "Quetrex"?

**Que**ue + O**r**ches**t**ration + **Ex**ecution

A system that queues work, orchestrates agents, and executes with strict quality controls.

---

## License

MIT

---

## Contributing

This is Glen Barnhardt's personal development environment. Feel free to fork and adapt for your own workflow.
