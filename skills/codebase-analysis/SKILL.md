---
name: codebase-analysis
description: "Comprehensive codebase analysis methodology. Used by the analyst agent to scan any project, detect tech stack, map dependencies, identify risks, and extract requirements. Trigger on: codebase scan, project analysis, dependency mapping, stack detection, risk assessment."
---

# Codebase Analysis Methodology

Guide for systematically analyzing any software project.

## Step 1: Stack Detection

Read CLAUDE.md first. If absent, scan in order:
1. package.json → Node.js ecosystem (check for react, next, svelte, vue, express)
2. requirements.txt / pyproject.toml → Python (check for flask, fastapi, django)
3. Cargo.toml → Rust
4. go.mod → Go
5. pom.xml / build.gradle → Java/Kotlin
6. Directory markers: app/, src/, pages/, components/

## Step 2: Structure Mapping

Use Glob to map:
- Top-level structure (depth 2)
- API endpoints (routes/, api/)
- Data models (models/)
- Tests (tests/, __tests__/)
- Migrations (migrations/, alembic/)

Build mental model: entry point → routes → business logic → data layer → external services.

## Step 3: Requirement Extraction

From user request, identify:
- What: desired outcome
- Where: affected files/modules
- Why: motivation (if stated)
- Constraints: compatibility, performance, security

## Step 4: Dependency Mapping

For affected files, trace:
- Upstream dependents (what imports them)
- Downstream dependencies (what they import)
- Shared state (databases, caches, globals)
- External APIs or services

## Step 5: Risk Identification

Check for:
- Breaking changes to public APIs
- Missing test coverage for affected areas
- Concurrent modification risks
- Performance implications
- Security implications

## Step 6: Scope Definition

State clearly:
- In scope: files and functionality that will change
- Out of scope: related but untouched areas
- Assumptions: what is taken as given

## Output Template

Write to _workspace/01_analyst_requirements.md with sections: Stack & Structure, Requirements, Affected Files (table), Dependencies & Impact, Risks & Edge Cases, Scope (in/out), Recommended Scale Mode.
