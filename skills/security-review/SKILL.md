---
name: security-review
description: "Security audit methodology based on OWASP Top 10 for identifying real vulnerabilities. Covers injection, auth, crypto, data exposure, misconfigurations. Trigger on: security review, vulnerability check, OWASP audit, security assessment."
---

# Security Review Methodology

## Prerequisites

1. Determine app exposure: internal vs. public-facing
2. Read `_workspace/03_build_summary.md` for changed files
3. Read the actual changed code

## Step 1: Threat Model

Who accesses this? What data? Blast radius if compromised? This calibrates severity.

## Step 2: OWASP Checklist

### Input Handling
- SQL injection: queries parameterized?
- XSS: output escaped?
- Command injection: user input in shell commands?
- Path traversal: user input in file paths?

### Auth & Authorization
- Endpoints protected?
- Authorization checked (not just authentication)?
- Sessions managed securely?
- Passwords hashed properly?

### Data Protection
- Sensitive data encrypted?
- Secrets hardcoded?
- PII in logs?
- Error messages leaking internals?

### Configuration
- Debug mode off in production?
- CORS restrictive?
- Security headers present?

## Step 3: Dependency Check

Check for known CVEs. Python: `pip audit`. Node: `npm audit`.

## Step 4: Classify

Critical (exploitable now), High (exploitable with effort), Medium (defense-in-depth), Low (hardening).

## Output

Write to `_workspace/04_security_review.md`: Threat Model, Findings by severity (File, OWASP Category, Issue, Exploit scenario, Fix), Clean Areas, Dependency Status.
