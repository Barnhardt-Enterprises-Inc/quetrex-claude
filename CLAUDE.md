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
2. Read codebase-map skill if available
3. Create/reference GitHub issue
4. Create feature branch in worktree
5. Never work in main repo during implementation

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
