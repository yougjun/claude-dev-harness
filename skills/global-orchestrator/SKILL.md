---
name: global-orchestrator
description: "Coordinates a 7-agent team for full development lifecycle across any tech stack. Auto-detects project stack and selects scale mode (single/reduced/full). Trigger on: feature development, bug fixing, refactoring, testing, deployment, code review, security audit, or any multi-step development task. Also: re-run, update, continue, resume, revise, partial re-execution. Does NOT trigger for: simple questions, file exploration, or when user says 'no harness'."
---

# Global Development Orchestrator

Coordinates a 7-agent team for full development lifecycle across any tech stack.

## Execution Modes

| Phase | Mode | Why |
|-------|------|-----|
| Analysis | Subagent | Analyst works solo |
| Design | Team | Analyst + architect collaborate |
| Build | Team | Implementer + tester incremental QA |
| Review | Parallel subagents | Independent reviews |
| Deploy | Subagent | DevOps works solo |

## Agent Roster

| Agent | Role | Skill |
|-------|------|-------|
| analyst | Codebase analysis, requirements | codebase-analysis |
| architect | Solution design | architecture-design |
| implementer | Code writing | feature-implementation |
| tester | Test creation & execution | testing |
| code-reviewer | Code quality review | code-review |
| security-reviewer | Security audit | security-review |
| devops | Deployment & verification | deployment |

## Phase 0: Context Detection

1. Read project CLAUDE.md for stack, structure, commands
2. If no CLAUDE.md: detect via marker files (package.json, requirements.txt, Cargo.toml, go.mod)
3. Check `_workspace/` existence:
   - Not found → initial execution, proceed to Phase 1
   - Found + user requests partial update → re-run only the requested phase
   - Found + user provides new task → archive to `_workspace_{timestamp}/`, start fresh
4. Select scale mode:
   - **Single**: 1-file change, typo, config → implementer only
   - **Reduced**: Bug fix, small feature, <5 files → analyst → implementer → tester
   - **Full**: Major feature, multi-file, architectural → all 7 agents

## Phase 1: Analysis (Subagent)

1. Create `_workspace/` directory
2. Dispatch analyst agent with the user's task description
3. Read analyst output, confirm scale mode
4. If Single → skip to Phase 3 (implementer only)
5. If Reduced → skip to Phase 3 (analyst output feeds directly to implementer + tester)

## Phase 2: Design (Agent Team)

1. Create team with analyst and architect
2. Architect reads `_workspace/01_analyst_requirements.md` and designs the solution
3. Analyst is available to answer clarification questions
4. Architect writes `_workspace/02_architect_design.md`
5. Delete team, proceed to Phase 3

## Phase 3: Build (Agent Team or Subagent)

**Single mode**: dispatch implementer as solo subagent, skip to Phase 5.

**Reduced/Full mode**:
1. Create team with implementer and tester
2. Implementer builds from the design (or analyst output for reduced mode)
3. Tester writes and runs tests per module as implementer completes them
4. Fix-test loop: max 3 iterations per module
5. Implementer writes `_workspace/03_build_summary.md`, tester writes `_workspace/03_test_results.md`
6. Delete team

## Phase 4: Review (Parallel Subagents)

1. Dispatch code-reviewer and security-reviewer simultaneously (run in background)
2. Code-reviewer writes `_workspace/04_code_review.md`
3. Security-reviewer writes `_workspace/04_security_review.md`
4. Wait for both to complete
5. Present summary to user — reviews are advisory, user decides what to act on

## Phase 5: Deploy (Subagent)

1. Ask user: "Reviews complete. Deploy now?"
2. If yes: dispatch devops agent
3. DevOps writes `_workspace/05_deploy_status.md`
4. Report deployment status

## Phase 6: Summary

Present to user:
- Analysis: key findings
- Design: approach taken
- Implementation: files changed
- Tests: passed/failed
- Code Review: findings by severity
- Security: findings by severity
- Deployment: status

## Data Flow

```
_workspace/
  01_analyst_requirements.md
  02_architect_design.md
  03_build_summary.md
  03_test_results.md
  04_code_review.md
  04_security_review.md
  05_deploy_status.md
```

## Error Handling

| Situation | Action |
|-----------|--------|
| Agent fails | 1 retry, then skip phase and note the gap |
| Test failure in Phase 3 | Implementer fixes, tester re-runs (max 3 loops) |
| Review finds critical issue | Report to user, do not auto-fix |
| Deploy fails | Check logs, report, no retry without user approval |
| Partial re-execution | Re-run only the requested phase, keep other outputs |
