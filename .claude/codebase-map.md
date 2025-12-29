# Codebase Map

> This file is auto-generated and should be updated when the codebase structure changes.
> Claude MUST read this file BEFORE searching the codebase.

## Project Overview

**Project:** quetrex-claude
**Type:** Claude Code Plugin
**Purpose:** Hardened development environment for autonomous Next.js 15 development

---

## Directory Structure

```
quetrex-claude/
├── .claude-plugin/          # Plugin marketplace configuration
│   ├── marketplace.json     # Marketplace metadata
│   └── plugin.json          # Plugin manifest
├── .claude/                  # Claude-specific files
│   └── codebase-map.md      # This file
├── agents/                   # Specialized agent definitions
│   ├── orchestrator.md      # Main coordinator (NEVER writes code)
│   ├── designer.md          # UI/UX design
│   ├── architect.md         # Technical specifications
│   ├── nextjs-developer.md  # Implementation
│   ├── test-runner.md       # Test execution (READ-ONLY)
│   ├── qa-fixer.md          # Fix failing tests
│   ├── reviewer.md          # Code review
│   └── security.md          # Security audits
├── commands/                 # Slash commands
│   ├── init.md              # /init - Initialize project
│   ├── plan.md              # /plan - Design + architecture
│   ├── build.md             # /build - Implement from spec
│   ├── fix.md               # /fix - Bug fixes
│   ├── spawn.md             # /spawn - Create agent tabs
│   ├── status.md            # /status - Check progress
│   ├── ship.md              # /ship - Deploy to production
│   ├── checkpoint.md        # /checkpoint - Save to memory
│   ├── recover.md           # /recover - Restore from memory
│   ├── create-term-project.md  # WezTerm project setup
│   └── change-term-tab-color.md # WezTerm tab colors
├── skills/                   # Domain knowledge
│   ├── typescript-strict/   # Strict TypeScript patterns
│   ├── nextjs-15-patterns/  # Next.js 15 App Router
│   ├── state-management/    # TanStack Query + Zustand
│   ├── drizzle-patterns/    # Drizzle ORM patterns
│   ├── shadcn-framer/       # UI components
│   ├── redis-patterns/      # Upstash Redis caching
│   ├── git-workflow/        # Git best practices
│   ├── checkpoint/          # Memory-keeper checkpointing
│   └── recovery/            # Session recovery
├── hooks/                    # Enforcement hooks
│   ├── hooks.json           # Hook configuration
│   └── scripts/             # Hook scripts
│       ├── enforce-branch.sh    # Block main branch
│       ├── typecheck.sh         # Run tsc after edits
│       ├── lint.sh              # Run biome after edits
│       ├── config-guard.sh      # Protect configs
│       ├── test-guard.sh        # Protect test files
│       └── checkpoint-reminder.sh # Memory checkpoint reminders
├── CLAUDE.md                 # Development standards + enforcement
└── README.md                 # Project documentation
```

---

## Key Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | **READ FIRST** - All development rules and enforcement |
| `agents/orchestrator.md` | Entry point for multi-step tasks |
| `agents/nextjs-developer.md` | Main code implementation agent |
| `hooks/hooks.json` | Hook configuration |
| `.claude-plugin/plugin.json` | Plugin manifest |

---

## Agent Hierarchy

```
orchestrator
├── designer (UI/UX)
├── architect (specs)
├── nextjs-developer (code)
│   └── qa-fixer (when tests fail)
├── test-runner (read-only)
├── reviewer (code review)
└── security (audit)
```

---

## Workflow Entry Points

| Task Type | Entry Point |
|-----------|-------------|
| New feature | `/plan` → `/build` |
| Bug fix | `/fix` |
| Multi-step work | `orchestrator` agent |
| Single file edit | `nextjs-developer` agent |
| Test execution | `test-runner` agent |
| Code review | `reviewer` agent |

---

## Memory-Keeper Integration

- Checkpoint every 5-10 tool calls
- Use `/checkpoint` for manual saves
- Use `/recover` to restore from previous session
- Memory stored via MCP memory-keeper server

---

## Last Updated

This map should be updated when:
- New files/directories are added
- Agent responsibilities change
- Workflow patterns change

**To update this file:**
1. Run exploration to understand current state
2. Update the structure and key files sections
3. Verify agent hierarchy is accurate
