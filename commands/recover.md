---
description: Recover session state from memory-keeper after context loss.
allowed-tools: Read, Glob
---

# /recover

Restore previous session state from memory-keeper checkpoints.

## Process

1. **Load Recent Context**
   ```
   context_get(limit: 50, sort: "created_desc")
   context_summarize()
   ```

2. **Find Progress Items**
   ```
   context_get(category: "progress", limit: 20)
   context_get(priority: "high", limit: 10)
   ```

3. **Reconstruct State**
   Extract from context:
   - `current-task`: What was being worked on
   - `files-modified`: Files that were changed
   - `implementation-progress`: How far along
   - `next-action`: What needs to happen next
   - `blockers`: Any known issues

4. **Present Recovery Summary**
   ```markdown
   ## Session Recovered

   ### Previous Task
   <current-task>

   ### Progress
   <implementation-progress>

   ### Files Modified
   - file1.ts
   - file2.tsx

   ### Next Action
   <next-action>

   ### Recent Checkpoints
   1. checkpoint-name: description
   2. checkpoint-name: description

   ---

   Ready to continue. Reply "continue" to proceed with: <next-action>
   Or provide different instructions.
   ```

5. **On Confirmation**
   - Restore todo list if available
   - Set context for continuation
   - Proceed with next-action

## If No Context Found

```markdown
## No Previous Context Found

No checkpoints found in memory-keeper.

This could mean:
- New session with no prior work
- Previous session didn't checkpoint
- Memory was cleared

To start fresh, describe what you'd like to work on.
```

## Recovery Tips

- Works best when checkpoints were saved frequently
- High-priority items are recovered first
- Check `files-modified` against actual files to verify state
- Review todo list reconstruction carefully
