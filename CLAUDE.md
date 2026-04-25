# CLAUDE.md — claude-dev-harness

## Overview
Reusable 7-agent development team for Claude Code. Drop-in agents and skills for analysis, architecture, implementation, testing, code review, security review, and deployment.

This project is self-referential: `.claude/agents` and `.claude/skills` are symlinks to the repo's own `agents/` and `skills/`. When you work in this directory, Claude Code discovers and uses the harness — so you can use it to improve itself.

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Platform | Claude Code (agents + skills) |
| Format | Markdown with YAML frontmatter |
| Installer | Bash (install.sh) |
| VCS | Git + GitHub |

## Structure
```
claude-dev-harness/
├── .claude/
│   ├── agents -> ../agents    # symlink (self-referential)
│   └── skills -> ../skills    # symlink (self-referential)
├── agents/           # 7 agent definitions (.md)
├── skills/           # 8 skill methodologies (SKILL.md + references/)
├── templates/        # CLAUDE.md.template for new projects
├── examples/         # Flask and Next.js example configs
├── install.sh        # Installer with backup/conflict detection
├── README.md         # Documentation
└── LICENSE           # MIT
```

## Key Files
- `agents/*.md` — agent frontmatter (name, description, skills) + system prompt body
- `skills/*/SKILL.md` — skill frontmatter (name, description) + methodology body
- `skills/*/references/*.md` — stack-specific patterns (python, react, go, rust, jvm, e2e)
- `install.sh` — copies agents/ and skills/ to ~/.claude/

## Conventions
- Agent `model` field omitted (defaults to `inherit`)
- Agent `skills` field links each agent to its corresponding skill
- Skill `description` kept under 1,536 chars (truncation limit in listings)
- No AI-style enforcement language (no ALWAYS/NEVER/forced phrases)
- Core explanations only — practical, not prescriptive
- Official docs: https://docs.anthropic.com/en/docs/claude-code

## Git
```bash
git push origin main
```

## Harness: Development

**Trigger:** Non-trivial development tasks (3+ steps, multi-file changes)
  -> use `global-orchestrator` skill. Simple questions -> direct answer.

**Self-referential**: `.claude/` symlinks point to repo's own agents/ and skills/, so the harness is used to develop itself.

**Scale Modes:**
- Single: 1-file changes -> implementer only
- Reduced: Bug fixes, small features -> analyst -> implementer -> tester
- Full: Major features, new modules -> all 7 agents

**Change History:**
| Date | Change | Target | Reason |
|------|--------|--------|--------|
| 2026-04-25 | Initial repo creation | All | 7 agents, 8 skills, installer |
| 2026-04-25 | Official docs alignment | All | Remove model:opus, add skills field, clean pseudo-API |
| 2026-04-26 | Self-referential setup | .claude/ | Symlinks so harness uses itself |
