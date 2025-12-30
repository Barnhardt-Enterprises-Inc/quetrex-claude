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

### Semantic Codebase Intelligence

**No more repetitive grep searches.** Quetrex mandates Serena's semantic tools:

```
# Serena - LSP-powered symbol navigation
mcp__serena__find_symbol(name_path: "UserService")
mcp__serena__find_referencing_symbols(name_path: "handleAuth")
mcp__serena__search_for_pattern(substring_pattern: "authentication middleware")
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
| **serena** | LSP-powered symbol intelligence and semantic search |
| **memory-keeper** | Persistent context across sessions |
| **github** | Issue/PR automation |

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
