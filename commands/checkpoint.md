---
description: Save current progress to memory-keeper to prevent work loss.
allowed-tools: Read, Glob
---

# /checkpoint [description]

Save current session state to memory-keeper. Use frequently to prevent losing work when context is exhausted.

## Process

1. **Gather Current State**
   - Read current todo list
   - Identify files modified this session
   - Determine current task and progress
   - Note any blockers

2. **Save to Memory-Keeper**
   ```
   context_save(key: "current-task", value: "<task>", category: "progress", priority: "high")
   context_save(key: "files-modified", value: "<file list>", category: "progress")
   context_save(key: "implementation-progress", value: "<progress>", category: "progress")
   context_save(key: "next-action", value: "<next step>", category: "progress", priority: "high")
   ```

3. **Create Named Checkpoint**
   ```
   context_checkpoint(
     name: "manual-checkpoint-<timestamp>",
     description: "<user description or auto-generated summary>"
   )
   ```

4. **Confirm**
   ```
   Checkpoint saved:
   - Task: <current task>
   - Progress: <progress>
   - Files: <count> modified
   - Next: <next action>

   Use /recover to restore this state if needed.
   ```

## When to Use

- Before taking a break
- After completing a significant milestone
- Before running risky operations
- When context feels "heavy"
- Every 10-15 minutes during active development

## Auto-Checkpoint Reminder

You will be reminded to checkpoint every 10 tool calls. Don't ignore these reminders!
