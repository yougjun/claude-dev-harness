---
name: global-orchestrator
description: "Universal development orchestrator that coordinates a 7-agent team for any software project. Auto-triggers on non-trivial development tasks: feature development, bug fixing, refactoring, testing, deployment, code review, security audit. Auto-detects project stack and selects appropriate scale mode (single/reduced/full). Use when: 'build a feature', 'fix this bug', 'refactor this', 'add tests', 'deploy', 'review code', 'security audit', or any multi-step development task. Also triggers on: re-run, update, continue, resume previous work, improve, revise, partial re-execution. Does NOT trigger for: simple questions, file exploration, conversation, or when user says 'no harness'."
---

# Global Development Orchestrator

Coordinates a 7-agent team for full development lifecycle across any tech stack.

## Execution Mode: Hybrid

| Phase | Mode | Reason |
|-------|------|--------|
| Phase 1: Analysis | Subagent | Analyst works solo |
| Phase 2: Design | Team | Analyst + architect collaborate |
| Phase 3: Build | Team | Implementer + tester incremental QA |
| Phase 4: Review | Fan-out subagents | Independent parallel reviews |
| Phase 5: Deploy | Subagent | DevOps works solo |

## Agent Roster

| Agent | Type | Role | Skill |
|-------|------|------|-------|
| analyst | Custom | Codebase analysis, requirements | codebase-analysis |
| architect | Custom | Solution design | architecture-design |
| implementer | Custom | Code writing | feature-implementation |
| tester | Custom | Test creation & execution | testing |
| code-reviewer | Custom | Code quality review | code-review |
| security-reviewer | Custom | Security audit | security-review |
| devops | Custom | Deployment & verification | deployment |

## Workflow

### Phase 0: Context Detection

1. Read project CLAUDE.md for stack, structure, commands
2. If no CLAUDE.md: detect via marker files (package.json, requirements.txt, Cargo.toml, go.mod)
3. Check _workspace/ existence:
   - Not found → initial execution, proceed to Phase 1
   - Found + user requests partial update → partial re-execution, run only requested phase
   - Found + user provides new task → new execution, move _workspace/ to _workspace_{YYYYMMDD_HHMMSS}/
4. Select scale mode (read references/scale-modes.md for detailed criteria):
   - Single: 1-file change, typo, config → implementer only
   - Reduced: Bug fix, small feature, <5 files → analyst → implementer → tester
   - Full: Major feature, multi-file, architectural → all 7 agents

### Phase 1: Analysis
**Execution mode:** Subagent

1. Create _workspace/ directory
2. Dispatch analyst as subagent:
   ```
   Task(
     subagent_type: "analyst",
     model: "opus",
     prompt: "Read the project CLAUDE.md. Analyze the codebase for this task: {user_request}. Write your analysis to _workspace/01_analyst_requirements.md."
   )
   ```
3. Read analyst output, confirm scale mode selection
4. If Single → skip to Phase 3 (implementer only, no design needed)
5. If Reduced → skip to Phase 3 (analyst output feeds directly to implementer + tester)

### Phase 2: Design
**Execution mode:** Agent Team

1. Create team with analyst and architect:
   ```
   TeamCreate(
     team_name: "design-team",
     members: [
       { name: "analyst-advisor", agent_type: "analyst", model: "opus",
         prompt: "Your analysis is in _workspace/01_analyst_requirements.md. Answer the architect's questions and clarify requirements." },
       { name: "architect-lead", agent_type: "architect", model: "opus",
         prompt: "Read _workspace/01_analyst_requirements.md. Design the solution. Write to _workspace/02_architect_design.md." }
     ]
   )
   ```
2. Create tasks for design collaboration
3. Monitor until architect completes design
4. TeamDelete, proceed to Phase 3

### Phase 3: Build
**Execution mode:** Agent Team (Full/Reduced) or Subagent (Single)

1. For Single mode: dispatch implementer as solo subagent, skip to Phase 5
2. For Reduced/Full: create team:
   ```
   TeamCreate(
     team_name: "build-team",
     members: [
       { name: "builder", agent_type: "implementer", model: "opus",
         prompt: "Read _workspace/02_architect_design.md (or user request for reduced). Implement changes. Notify tester-qa after each module. Write summary to _workspace/03_build_summary.md." },
       { name: "tester-qa", agent_type: "tester", model: "opus",
         prompt: "Wait for builder notifications. Write and run tests per module. Report failures via SendMessage. Write results to _workspace/03_test_results.md." }
     ]
   )
   ```
3. Monitor: implementer-tester loop (max 3 iterations per module)
4. TeamDelete after build + tests complete

### Phase 4: Review
**Execution mode:** Fan-out Subagents (parallel)

1. Dispatch both reviewers simultaneously:
   ```
   Task(subagent_type: "code-reviewer", model: "opus",
     prompt: "Review code changes. Read _workspace/03_build_summary.md. Write to _workspace/04_code_review.md.",
     run_in_background: true)

   Task(subagent_type: "security-reviewer", model: "opus",
     prompt: "Security audit code changes. Read _workspace/03_build_summary.md. Write to _workspace/04_security_review.md.",
     run_in_background: true)
   ```
2. Wait for both to complete
3. Read both reports, present summary to user
4. Reports are advisory — user decides what to act on

### Phase 5: Deploy
**Execution mode:** Subagent

1. Ask user: "Reviews complete. Deploy now?"
2. If yes:
   ```
   Task(subagent_type: "devops", model: "opus",
     prompt: "Deploy changes. Read CLAUDE.md for commands. Write to _workspace/05_deploy_status.md.")
   ```
3. Report deployment status to user

### Phase 6: Summary

Present to user:
```
## Task Complete
- Analysis: {summary}
- Design: {summary}
- Implementation: {files changed}
- Tests: {passed/failed}
- Code Review: {findings by severity}
- Security: {findings by severity}
- Deployment: {status}
```

## Data Flow

```
Phase 0 → detect stack + scale mode
Phase 1 → _workspace/01_analyst_requirements.md
Phase 2 → _workspace/02_architect_design.md
Phase 3 → code files + _workspace/03_build_summary.md + _workspace/03_test_results.md
Phase 4 → _workspace/04_code_review.md + _workspace/04_security_review.md
Phase 5 → _workspace/05_deploy_status.md
```

## Error Handling

| Situation | Strategy |
|-----------|----------|
| Agent fails | 1 retry → skip phase, note gap in summary |
| Test failure in Phase 3 | Implementer fixes → tester re-runs (max 3 loops) |
| Review finds critical issue | Report to user, do not auto-fix |
| Deploy fails | Check logs, report, no retry without user approval |
| Partial re-execution | Re-run only requested phase, keep other outputs |

## Test Scenarios

### Normal Flow
1. User: "Add a REST endpoint for user profile"
2. Phase 0: Detect FastAPI, select Full mode
3. Phase 1: Analyst identifies models, routes, schemas
4. Phase 2: Architect designs endpoint, data flow
5. Phase 3: Implementer creates route + model, tester writes API tests
6. Phase 4: Code reviewer approves, security reviewer flags missing auth
7. Phase 5: DevOps restarts server, health check passes

### Error Flow
1. User: "Fix the login bug"
2. Phase 0: Detect Flask, select Reduced mode
3. Phase 1: Analyst traces bug to session handling
4. Phase 3: Implementer fixes, tester writes regression test
5. Test fails → fix → passes (1 loop)
6. Phase 5: User confirms → DevOps restarts
