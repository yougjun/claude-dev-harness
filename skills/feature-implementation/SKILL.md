---
name: feature-implementation
description: "Code implementation methodology for any tech stack. Used by the implementer agent to write production-quality code following project conventions. Covers Python, JavaScript/TypeScript, Go, Rust, Java/Kotlin. Trigger on: code writing, feature building, bug fixing, refactoring, implementation."
---

# Feature Implementation Methodology

Write production-quality code across any stack.

## Prerequisites

1. Read project CLAUDE.md for conventions
2. Read `_workspace/02_architect_design.md` if exists (full mode)
3. Read `_workspace/01_analyst_requirements.md` if exists (reduced mode)

## Step 1: Understand Before Writing

- Read existing code in the affected area
- Identify conventions: naming, file structure, import style, error handling
- Check for existing utilities/helpers to reuse

## Step 2: Write Code

- Match existing style
- Minimum viable code — exactly what's needed
- Validate inputs, parameterize queries, escape outputs
- No dead code, no commented-out code, no unused imports

## Step 3: Stack-Specific Guidance

Load relevant reference based on detected stack:
- Python → references/python-patterns.md
- React/Next.js/TypeScript → references/react-patterns.md
- Go → references/go-patterns.md
- Rust → references/rust-patterns.md
- Java/Kotlin → references/jvm-patterns.md
- Other → references/general-patterns.md

## Step 4: Incremental Build

1. Create/modify one logical unit
2. Notify tester: "Module X ready"
3. Wait for test feedback
4. Fix issues if any
5. Move to next unit

## Step 5: Build Summary

Write to `_workspace/03_build_summary.md`: Files Created, Files Modified, Dependencies Added, Manual Steps Required.
