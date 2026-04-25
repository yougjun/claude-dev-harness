---
name: code-review
description: "Code quality review methodology. Used by the code-reviewer agent to systematically review for correctness, patterns, duplication, complexity, and maintainability. Trigger on: code review, quality check, PR review, code quality, review changes."
---

# Code Review Methodology

## Prerequisites

1. Read project CLAUDE.md for conventions
2. Read _workspace/03_build_summary.md for changed files
3. Read the actual changed files

## Step 1: Understand Context

What was the task? What was the design? Does implementation match design?

## Step 2: Correctness Review

Per changed file: Does code do what it should? Logic errors? Error conditions handled? Edge cases?

## Step 3: Quality Review

Duplication (repeated code to extract?), Complexity (functions >30 lines?), Naming (clear, consistent?), Dependencies (justified?).

## Step 4: Convention Compliance

Does new code follow existing patterns? File/folder structure consistent? Error handling consistent?

## Step 5: Classify Findings

| Severity | Criteria | Action |
|----------|----------|--------|
| Critical | Bug causing failure | Must fix |
| High | Will cause problems | Should fix |
| Medium | Quality improvement | Recommend |
| Low | Nice to have | Optional |

## Output Template

Write to _workspace/04_code_review.md: Summary (2-3 sentences), Findings by severity (file:line, description, suggestion), Positive Observations, Recommendation (approve / approve with changes / request changes).
