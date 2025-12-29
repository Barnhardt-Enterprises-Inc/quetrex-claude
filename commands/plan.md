---
description: Plan a feature with design + architecture. Human approves before build.
allowed-tools: Task, Read, Write, Bash, Grep, Glob
---

# /plan <feature description>

## Process

1. **Spawn Designer**
   - User flow, UI mockups, components
   - Present for human feedback

2. **Spawn Architect**
   - Technical spec, data model, API design
   - Test plan (tests first)
   - Save to `.claude/specs/{slug}.md`

3. **Human Approval**
   ```
   ## Feature Plan: [name]

   ### Design
   [output]

   ### Architecture
   [output]

   Ready? Reply "approved" or provide feedback.
   ```

4. **On Approval**
   - Create GitHub issue
   - Save to memory
   - Prompt: `/build {issue-number}`

---

## MANDATORY: Checkpointing Protocol

**FAILURE TO CHECKPOINT = POTENTIAL TOTAL WORK LOSS**

### At Plan Start
```
context_save(key: "planning-started", value: "<feature description>", category: "planning", priority: "high")
```

### After Design Phase
```
context_save(key: "design-complete", value: "<summary of design>", category: "planning")
context_checkpoint(name: "design-phase-complete", description: "<feature> design ready")
```

### After Architecture Phase
```
context_save(key: "spec-complete", value: "<spec file path and summary>", category: "planning", priority: "high")
context_checkpoint(name: "architecture-phase-complete", description: "<feature> spec saved")
```

### On Approval
```
context_save(key: "plan-approved", value: "issue #{issue}: <feature>", category: "planning", priority: "high")
context_checkpoint(name: "planning-complete", description: "<feature> approved, ready for /build #{issue}")
context_save(key: "next-action", value: "Run /build #{issue}", priority: "high")
```
