---
description: Autonomous build from approved spec. Human OUT of loop until done.
allowed-tools: Task, Read, Write, Bash, Grep, Glob
---

# /build <issue-number>

## Pre-flight
- Verify issue exists
- Verify spec exists
- Not on main
- Clean git status

## Setup
```bash
git worktree add "../worktrees/feature-{issue}-{slug}" -b "feature/{issue}-{slug}"
```

## Execution

1. **Spawn Developer** in worktree
2. **Monitor** via memory
3. **On Complete**: Spawn test-runner
4. **If Fail**: Spawn qa-fixer (max 10x)
5. **On Pass**: Spawn reviewer
6. **On Review Pass**: Create PR

```bash
gh pr create --title "feat: {title}" --body "Closes #{issue}" --base main
```

## Notify Human
```
## Build Complete

**PR:** #{number}
**Branch:** feature/{issue}-{slug}

Review at: ../worktrees/feature-{issue}-{slug}
```

## On Failure
```
## Build Failed

**Failed At:** [stage]
**Error:** [details]
**Tried:** [list]

Recovery: Fix manually or restart
```

---

## MANDATORY: Checkpointing Protocol

**FAILURE TO CHECKPOINT = POTENTIAL TOTAL WORK LOSS**

### At Build Start
```
context_save(key: "build-started", value: "issue #{issue}: {title}", category: "build", priority: "high")
context_save(key: "implementation-plan", value: "<full plan from spec>", priority: "high")
```

### After Each Phase
```
context_checkpoint(name: "build-phase-<N>", description: "<phase name> complete for issue #{issue}")
```

**Phase checkpoints:**
1. After worktree setup
2. After developer completes implementation
3. After test-runner reports results
4. After qa-fixer resolves issues (if any)
5. After reviewer approves
6. After PR creation

### After EVERY File Written
```
context_save(key: "file-<filename>", value: "<summary of changes>", category: "progress")
```

### Before Large Operations
```
context_prepare_compaction()
```

### On Build Complete or Failure
```
context_checkpoint(name: "build-complete", description: "issue #{issue}: <success/failed at phase>")
context_save(key: "build-result", value: "<PR number or failure details>", category: "build", priority: "high")
context_save(key: "next-action", value: "<what to do next>", priority: "high")
```
