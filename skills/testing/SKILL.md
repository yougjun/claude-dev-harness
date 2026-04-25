---
name: testing
description: "Test creation and execution methodology for any project. Used by the tester agent to write meaningful tests, run suites, and report coverage. Covers pytest (Python), Vitest/Jest (JavaScript/TypeScript). Trigger on: test writing, test execution, coverage analysis, QA, verification."
---

# Testing Methodology

Guide for writing and running tests across any stack.

## Prerequisites

1. Detect test framework: Python → pytest, JS/TS → Vitest or Jest
2. Read existing tests to understand conventions
3. Read _workspace/01_analyst_requirements.md for what to verify

## Step 1: Identify What to Test

From implementation changes: new functions (test inputs → outputs), new endpoints (test request → response), modified behavior (test the change), edge cases (boundary values, empty inputs, errors).

## Step 2: Write Tests

For each testable unit:
1. Happy path: normal input → expected output
2. Edge case: boundary values, empty/null
3. Error case: invalid input → appropriate error

Keep tests focused, independent, readable.

## Step 3: Run Tests

- Python: pytest {test_file} -v
- JS/TS: npm run test or npx vitest run {test_file}

## Step 4: Report Results

Write to _workspace/03_test_results.md: Summary (total/passed/failed/skipped), Failed Tests (table), Coverage (table), Edge Cases (covered/not covered).

## Stack-Specific Patterns
- Python → Read references/pytest-patterns.md
- JS/TS → Read references/vitest-patterns.md
- Go → Read references/go-test-patterns.md
- Rust → Read references/rust-test-patterns.md
- E2E → Read references/e2e-patterns.md
