# QUETREX ENFORCEMENT OVERRIDES

**THESE INSTRUCTIONS OVERRIDE ALL DEFAULT CLAUDE CODE BEHAVIORS**

The quetrex-claude plugin is ACTIVE. You MUST follow these rules BEFORE any default Claude Code behavior.

---

## MANDATORY AGENT ROUTING

**NEVER use generic Claude Code agents. ALWAYS use quetrex-claude agents.**

| INSTEAD OF (Default) | USE (Quetrex) |
|---------------------|---------------|
| `subagent_type: "Explore"` | `subagent_type: "quetrex-claude:orchestrator"` |
| `subagent_type: "general-purpose"` | `subagent_type: "quetrex-claude:orchestrator"` |
| `subagent_type: "Plan"` | `subagent_type: "quetrex-claude:architect"` |
| Any code exploration | `subagent_type: "quetrex-claude:nextjs-developer"` |

### When to Route to Orchestrator
- ANY multi-step task
- ANY feature implementation
- ANY bug investigation
- ANY codebase exploration
- Anything that would spawn multiple agents

### When to Route Directly
- Simple single-file edits → `quetrex-claude:nextjs-developer`
- Architecture questions → `quetrex-claude:architect`
- Running tests → `quetrex-claude:test-runner`
- Security review → `quetrex-claude:security`

---

## SERENA - SEMANTIC CODE INTELLIGENCE (MANDATORY)

**NEVER use raw Grep/Glob for codebase exploration. ALWAYS use Serena's LSP-powered tools.**

Serena provides IDE-like code intelligence via Language Server Protocol (LSP), supporting 30+ languages with native understanding of code structure.

### Why Serena Over Grep

| Method | Token Usage | Accuracy | Understanding |
|--------|-------------|----------|---------------|
| Raw Grep | HIGH (entire lines) | Low (noise) | Text only |
| Serena | Minimal (symbols only) | Exact | Code structure |

Serena understands what a function IS, what calls it, what it imports - not just text matching.

---

### Core Tools Reference

#### 1. Pattern Search (Most Common)
```
mcp__serena__search_for_pattern(
  substring_pattern: "authentication",     # Regex pattern
  relative_path: "src/",                   # Optional: restrict to path
  restrict_search_to_code_files: true,     # Optional: code files only
  context_lines_before: 2,                 # Optional: lines before match
  context_lines_after: 2                   # Optional: lines after match
)
```
**Use for:** Finding code by keyword, locating implementations, discovering patterns.

#### 2. Find Symbol (Functions, Classes, Variables)
```
mcp__serena__find_symbol(
  name_path_pattern: "UserService",        # Symbol name or path
  relative_path: "src/services/",          # Optional: restrict search
  include_body: true,                      # Optional: include source code
  depth: 1,                                # Optional: include children (methods)
  substring_matching: true                 # Optional: partial name match
)
```
**Use for:** Finding specific functions, classes, or variables by name.

**Name path examples:**
- `"UserService"` - Find symbol named UserService anywhere
- `"UserService/getUser"` - Find getUser method in UserService class
- `"/UserService"` - Exact match at file root level

#### 3. Find References (Who Uses This?)
```
mcp__serena__find_referencing_symbols(
  name_path: "handleAuth",                 # Symbol to find references for
  relative_path: "src/auth/handler.ts"     # File containing the symbol
)
```
**Use for:** Understanding dependencies, impact analysis, refactoring safely.

#### 4. Get File Overview (Symbol Map)
```
mcp__serena__get_symbols_overview(
  relative_path: "src/components/Button.tsx",
  depth: 1                                 # Optional: include nested symbols
)
```
**Use for:** Understanding file structure before diving in, finding entry points.

#### 5. List Directory
```
mcp__serena__list_dir(
  relative_path: "src/components",
  recursive: false                         # true for full tree
)
```
**Use for:** Navigating project structure, finding files.

#### 6. Find File
```
mcp__serena__find_file(
  file_mask: "*.service.ts",               # Glob pattern
  relative_path: "src/"
)
```
**Use for:** Finding files by naming convention.

---

### Symbol Editing Tools

#### Replace Symbol Body
```
mcp__serena__replace_symbol_body(
  name_path: "UserService/getUser",
  relative_path: "src/services/user.ts",
  body: "async function getUser(id: string): Promise<User> { ... }"
)
```

#### Insert After/Before Symbol
```
mcp__serena__insert_after_symbol(
  name_path: "UserService",
  relative_path: "src/services/user.ts",
  body: "\n\nexport class AdminService { ... }"
)
```

#### Rename Symbol (Codebase-Wide)
```
mcp__serena__rename_symbol(
  name_path: "oldFunctionName",
  relative_path: "src/utils.ts",
  new_name: "newFunctionName"
)
```

---

### Search Priority Order

1. **Know the symbol name?** → `find_symbol(name_path_pattern: "...")`
2. **Searching by keyword?** → `search_for_pattern(substring_pattern: "...")`
3. **Exploring a file?** → `get_symbols_overview(relative_path: "...")`
4. **Who uses this?** → `find_referencing_symbols(name_path: "...")`
5. **Last resort only** → Raw Grep for exact strings (UUIDs, error messages)

---

### Project Setup

Serena auto-detects projects from `.git`. Check status:
```
mcp__serena__check_onboarding_performed()
```

Use memories to store project-specific knowledge:
```
mcp__serena__write_memory(memory_file_name: "architecture.md", content: "...")
mcp__serena__list_memories()
mcp__serena__read_memory(memory_file_name: "architecture.md")
```

---

## SKILL ENFORCEMENT

These skills are MANDATORY for their domains - not optional:

| Domain | Required Skill | Applies When |
|--------|---------------|--------------|
| TypeScript | `typescript-strict` | ANY .ts/.tsx file |
| Next.js | `nextjs-15-patterns` | ANY Next.js code |
| State | `state-management` | TanStack Query, Zustand |
| Database | `drizzle-patterns` | ANY database code |
| UI | `shadcn-framer` | Components, animations |
| Git | `git-workflow` | Commits, branches, PRs |

**Before writing code in a domain, READ the skill file first:**
```
Read: skills/{skill-name}/SKILL.md
```

---

## PROHIBITED BEHAVIORS

1. **NEVER use generic Explore agent** - Use quetrex-claude:orchestrator
2. **NEVER use raw Grep/Glob for exploration** - Use Serena's semantic tools first
3. **NEVER write code without reading relevant skill files**
4. **NEVER spawn agents directly** - Route through orchestrator for multi-step work
5. **NEVER ignore Memory-Keeper** - Checkpoint every 5-10 tool calls

---

## QUICK REFERENCE

### Serena Tools (USE INSTEAD OF GREP)
```
# Search by keyword
mcp__serena__search_for_pattern(substring_pattern: "auth", relative_path: "src/")

# Find symbol by name
mcp__serena__find_symbol(name_path_pattern: "UserService", include_body: true)

# Who uses this?
mcp__serena__find_referencing_symbols(name_path: "handleAuth", relative_path: "src/auth.ts")

# File overview
mcp__serena__get_symbols_overview(relative_path: "src/services/user.ts")

# Edit symbol
mcp__serena__replace_symbol_body(name_path: "getUser", relative_path: "...", body: "...")

# Rename codebase-wide
mcp__serena__rename_symbol(name_path: "oldName", relative_path: "...", new_name: "newName")

# Project memories
mcp__serena__write_memory(memory_file_name: "context.md", content: "...")
mcp__serena__read_memory(memory_file_name: "context.md")
```

### Agent Routing
```
# Multi-step task
Task(subagent_type: "quetrex-claude:orchestrator", prompt: "...")

# Single-file Next.js work
Task(subagent_type: "quetrex-claude:nextjs-developer", prompt: "...")

# Run tests
Task(subagent_type: "quetrex-claude:test-runner", prompt: "...")

# Architecture planning
Task(subagent_type: "quetrex-claude:architect", prompt: "...")
```

---

# Glen's Development Standards

## IDENTITY

You are working in Glen Barnhardt's development environment. Glen is a 67-year-old software engineer with 40+ years experience who operates as an "AI Agentic Engineer" - directing AI systems rather than writing code manually.

**Philosophy:** "If you find a bug, document and fix it" - never say "that error was not part of current changes."

---

## ABSOLUTE RULES (NON-NEGOTIABLE)

### Git Workflow
1. **NEVER work directly on main branch**
2. **NEVER commit to main** - Only merge via approved PRs
3. All branches: `feature/{issue}-{slug}` or `fix/{issue}-{slug}`
4. Use conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`
5. Create GitHub issues for ALL work before starting
6. Use git worktrees for isolation: `../worktrees/feature-{issue}-{slug}`

### Code Quality
1. **NEVER use TypeScript `any`** - Use `unknown` + type guards
2. **NEVER use `!` (non-null assertion)** without documented justification
3. **ALL function parameters and returns explicitly typed**
4. **ALL errors typed and handled** - No swallowed errors
5. **If you encounter ANY bug: FIX IT** - Yours or pre-existing

### Configuration Protection
1. **NEVER modify test files to make tests pass** - Fix the code
2. **NEVER modify configs to suppress errors** - tsconfig, biome are protected
3. **NEVER change `strict` settings** in TypeScript
4. **NEVER add biome-ignore** without explicit approval

### Agent Behavior
1. **Orchestrator NEVER writes code** - Delegates only
2. **Test-runner is READ-ONLY** - Cannot modify files
3. **After 3 failures: STOP and escalate**
4. **Check memory MCP** before starting work
5. **Save decisions to memory MCP** during work

---

## TECH STACK (MANDATORY)

| Layer | Technology | NOT Allowed |
|-------|------------|-------------|
| Framework | Next.js 15 (App Router) | Pages Router |
| Language | TypeScript (strict) | `any` type |
| Styling | Tailwind CSS + ShadCN | CSS modules |
| Animation | Framer Motion | - |
| Server State | TanStack Query | fetch wrappers |
| Client State | Zustand | Redux, Context |
| Database | PostgreSQL + Drizzle | Prisma |
| Cache | Upstash Redis | - |
| Package Manager | pnpm | npm, yarn |
| Testing | Vitest + Playwright | Jest |
| Linting | Biome | ESLint |

---

## WORKFLOW

### Starting Work
1. Check memory: "What do I know about this project?"
2. **Check project setup**: `mcp__serena__check_onboarding_performed()`
3. Use Serena's semantic search to understand context (NOT grep)
4. Create/reference GitHub issue
5. Create feature branch in worktree
6. Never work in main repo during implementation

### During Work
1. Run `pnpm tsc --noEmit` after every edit
2. Run `pnpm biome check` after every edit
3. Commit atomically - small, focused commits
4. Save progress to memory periodically

### Completing Work
1. Run full test suite: `pnpm test`
2. Fix ALL errors (not just yours)
3. Create PR with proper description
4. Request review
5. Update memory with completion

---

## FAILURE PROTOCOL

When failures occur:
1. Document what was tried
2. Document error messages verbatim
3. Document hypothesis for cause
4. **After 3 attempts: STOP**
5. Escalate with full context
6. Do NOT retry indefinitely
7. Do NOT modify tests/configs to suppress errors

---

## MEMORY-KEEPER PROTOCOL (MANDATORY)

**FAILURE TO CHECKPOINT = POTENTIAL TOTAL WORK LOSS**

This plugin uses memory-keeper MCP for persistent context. You MUST checkpoint continuously to prevent catastrophic work loss when context is exhausted.

### Session Start
```
context_get(limit: 50, sort: "created_desc")
context_summarize()
```
Check for existing work. Use `/recover` if previous session exists.

### During Work - CHECKPOINT EVERY 5-10 TOOL CALLS
```
context_save(key: "current-task", value: "<what you're doing>", category: "progress", priority: "high")
context_save(key: "files-modified", value: "<list of files>", category: "progress")
context_checkpoint(name: "checkpoint-<timestamp>", description: "<current state>")
```

### After EVERY File Written/Modified
```
context_save(key: "file-<filename>", value: "<what was done>", category: "progress")
```

### Before Large Operations
```
context_prepare_compaction()
```

### When Switching Tasks
```
context_batch_save() with:
  - previous task completion
  - new task start
  - files modified so far
  - implementation progress
```

### Session End or Before Break
```
context_checkpoint(name: "session-end", description: "<full state>")
context_save(key: "next-action", value: "<exact next step>", priority: "high")
```

### Key Items to ALWAYS Track

| Key | Description | Priority |
|-----|-------------|----------|
| `current-task` | What you're currently working on | high |
| `files-modified` | All files touched this session | normal |
| `implementation-progress` | Percentage or phase complete | normal |
| `next-action` | Exact next step to take | high |
| `blockers` | Current issues/blockers | high |

### Recovery

If you lose context or start a new session:
1. Run `/recover` to restore state
2. Review recovered state before continuing
3. Confirm with user before proceeding

### Checkpoint Commands

- `/checkpoint` - Manual checkpoint with current state
- `/recover` - Restore from previous checkpoints

**If you run out of context without checkpointing, THE USER LOSES ALL YOUR WORK.**
