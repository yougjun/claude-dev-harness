# claude-dev-harness

A reusable 7-agent development team for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Drop-in agents and skills that coordinate analysis, architecture, implementation, testing, code review, security review, and deployment for any tech stack.

## Concepts

Claude Code supports [custom agents](https://docs.anthropic.com/en/docs/claude-code/sub-agents) (`.claude/agents/*.md`) and [skills](https://docs.anthropic.com/en/docs/claude-code/skills) (`.claude/skills/*/SKILL.md`). Agents define specialized roles with their own system prompts and tool access. Skills provide methodology and context that loads on demand.

This harness provides both — agents define _who does what_, skills define _how they do it_.

## What's Inside

### Agents (7)
| Agent | Role |
|-------|------|
| **analyst** | Codebase analysis, requirements extraction, dependency mapping |
| **architect** | Solution design, API contracts, data flow planning |
| **implementer** | Code writing across any stack |
| **tester** | Test creation and execution |
| **code-reviewer** | Code quality, patterns, maintainability |
| **security-reviewer** | OWASP Top 10, auth, injection, crypto |
| **devops** | Deployment, health checks, server management |

### Skills (8)
| Skill | Purpose |
|-------|---------|
| **global-orchestrator** | Coordinates the full team with auto-scaling |
| **codebase-analysis** | Methodology for scanning and understanding codebases |
| **architecture-design** | Design patterns, data flow, API contracts |
| **feature-implementation** | Stack-specific implementation guidance |
| **testing** | Test writing with framework-specific references |
| **code-review** | Systematic code quality review |
| **security-review** | OWASP-based security audit |
| **deployment** | Deployment and verification procedures |

### Stack Coverage
Implementation and testing references included for:
- **Python** (Flask, FastAPI, Django)
- **JavaScript/TypeScript** (React, Next.js, Svelte, Vite)
- **Go** (net/http, chi, gin)
- **Rust** (axum, actix-web, tokio)
- **Java/Kotlin** (Spring Boot, Gradle, Maven)
- **E2E** (Playwright, Cypress)

## Installation

### Quick Install
```bash
git clone https://github.com/yougjun/claude-dev-harness.git
cd claude-dev-harness
chmod +x install.sh
./install.sh
```

### Manual Install
Copy `agents/` and `skills/` to your `~/.claude/` directory:
```bash
cp -r agents/* ~/.claude/agents/
cp -r skills/* ~/.claude/skills/
```

### Add to CLAUDE.md
Add this harness pointer to your project's `CLAUDE.md`:
```markdown
## Harness: Development

**Trigger:** Non-trivial development tasks (3+ steps, multi-file changes)
  -> use `global-orchestrator` skill. Simple questions -> direct answer.

**Agents:** `~/.claude/agents/` (analyst, architect, implementer, tester,
  code-reviewer, security-reviewer, devops)
**Skills:** `~/.claude/skills/` (global-orchestrator + 7 domain skills)
```

See `templates/CLAUDE.md.template` for a complete starter template.

## How It Works

### Scale Modes
The orchestrator auto-detects task complexity and selects the right team size:

| Mode | When | Team |
|------|------|------|
| **Single** | 1-file change, typo, config | implementer only |
| **Reduced** | Bug fix, small feature, <5 files | analyst → implementer → tester |
| **Full** | Major feature, multi-file, architectural | all 7 agents |

### Workflow (Full Mode)
```
Phase 0: Context Detection (stack, scale mode)
Phase 1: Analysis (analyst scans codebase)
Phase 2: Design (architect + analyst collaborate)
Phase 3: Build (implementer + tester incremental QA)
Phase 4: Review (code-reviewer + security-reviewer in parallel)
Phase 5: Deploy (devops restarts, health check)
```

### Data Flow
Each phase produces artifacts in `_workspace/`:
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

## Agent Frontmatter

Each agent `.md` file uses YAML frontmatter. Key fields (from [official docs](https://docs.anthropic.com/en/docs/claude-code/sub-agents)):

| Field | Purpose | Default |
|-------|---------|---------|
| `name` | Agent identifier | Required |
| `description` | When to activate this agent (shown in agent picker) | Required |
| `model` | Model to use | `inherit` (parent model) |
| `skills` | Skills always active for this agent | None |
| `tools` | Allowed tools | All |
| `disallowedTools` | Tools to exclude | None |
| `maxTurns` | Max API round-trips | None |
| `permissionMode` | Permission level | Inherited |

## Skill Frontmatter

Each `SKILL.md` uses YAML frontmatter. Key fields (from [official docs](https://docs.anthropic.com/en/docs/claude-code/skills)):

| Field | Purpose | Default |
|-------|---------|---------|
| `name` | Skill identifier | Required |
| `description` | When to trigger (1,536 char limit in listings) | Required |
| `user-invocable` | Can be called as `/skill-name` | false |
| `allowed-tools` | Tools available during skill execution | All |
| `context` | Files/globs to auto-load as context | None |
| `agent` | Run skill in a specific agent | None |

## Customization

### Adding Stack-Specific Patterns
Add a reference file to the appropriate skill:
```
skills/feature-implementation/references/your-stack-patterns.md
skills/testing/references/your-stack-test-patterns.md
```
Then update the skill's SKILL.md to include the new reference.

### Creating Domain-Specific Harnesses
For project-specific agents, create agents and skills in your project's `.claude/` directory:
```
your-project/.claude/
  agents/flask-backend.md
  skills/flask-backend/SKILL.md
```
Project-level agents and skills take precedence over global ones. See `examples/flask-project/` for an example.

## Examples

- `examples/flask-project/` — Flask + SQLite project harness pointer
- `examples/nextjs-project/` — Next.js + Prisma project harness pointer

## References

- [Claude Code Agents](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [Claude Code Skills](https://docs.anthropic.com/en/docs/claude-code/skills)
- [Agent Teams](https://docs.anthropic.com/en/docs/claude-code/agent-teams) (experimental)

## License

MIT
