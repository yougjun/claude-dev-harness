---
name: deployment
description: "Deployment and operations methodology for deploying changes, verifying deployments, and performing health checks. Covers master.sh, PM2, Docker, npm scripts. Trigger on: deployment, server restart, health check, deploy verification, rollback."
---

# Deployment Methodology

## Prerequisites

1. Read project CLAUDE.md for deployment commands
2. Verify all tests passed
3. Check current server status

## Step 1: Detect Deployment Method

Priority order:
1. master.sh → `./master.sh restart`
2. ecosystem.config.js → `pm2 restart`
3. docker-compose.yml → `docker-compose up -d --build`
4. package.json scripts → `npm run build && npm run start`
5. Makefile → `make deploy`
6. Manual → ask user

## Step 2: Pre-deployment Check

Check server status, verify no uncommitted changes, confirm tests passed.

## Step 3: Deploy

Execute deployment command. Capture output.

## Step 4: Post-deployment Verification

Check process running, check logs (last 50 lines), health check (curl main endpoint).

## Step 5: Rollback (if failed)

Check logs for error, report to user, rollback only with user approval.

## Output

Write to `_workspace/05_deploy_status.md`: Pre-deployment (status, method, changes), Deployment (command, output), Post-deployment (status, health check, logs), Result (SUCCESS/FAILED).
