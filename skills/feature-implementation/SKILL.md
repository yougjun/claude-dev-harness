---
name: feature-implementation
description: "Code implementation methodology for any tech stack. Used by the implementer agent to write production-quality code following project conventions. Covers Python (Flask, FastAPI, Django), JavaScript/TypeScript (React, Next.js, Svelte), and general patterns. Trigger on: code writing, feature building, bug fixing, refactoring, implementation."
---

# Feature Implementation Methodology

Guide for writing production-quality code across any stack.

## Prerequisites

1. Read project CLAUDE.md for conventions
2. Read _workspace/02_architect_design.md if exists (full mode)
3. Read _workspace/01_analyst_requirements.md if exists (reduced mode)

## Step 1: Understand Before Writing

- Read existing code in the affected area
- Identify conventions: naming, file structure, import style, error handling
- Check for existing utilities/helpers to reuse

## Step 2: Write Code

- Match existing style
- Minimum viable code — exactly what's needed
- Security first — validate inputs, parameterize queries, escape outputs
- No dead code, no commented-out code, no unused imports

## Step 3: Stack-Specific Guidance

Load relevant reference based on detected stack:
- Python → Read references/python-patterns.md
- React/Next.js/TypeScript → Read references/react-patterns.md
- Go → Read references/go-patterns.md
- Rust → Read references/rust-patterns.md
- Java/Kotlin → Read references/jvm-patterns.md
- Other → Read references/general-patterns.md

## Step 4: Incremental Build

1. Create/modify one logical unit
2. Notify tester: "Module X ready"
3. Wait for test feedback
4. Fix issues if any
5. Move to next unit

## Step 5: Build Summary

Write to _workspace/03_build_summary.md: Files Created, Files Modified, Dependencies Added, Manual Steps Required.
