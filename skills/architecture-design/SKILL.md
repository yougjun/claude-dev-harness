---
name: architecture-design
description: "Solution architecture design methodology for designing data flows, component boundaries, API contracts, and implementation plans. Trigger on: architecture design, system design, API design, component planning, data flow design, technical decisions."
---

# Architecture Design Methodology

Design solutions that the implementer can follow.

## Prerequisites

Read `_workspace/01_analyst_requirements.md` before designing. If absent, request analysis phase first.

## Step 1: Approach Selection

Consider 2-3 approaches. For each: how it works, trade-offs, change surface, fit with existing patterns. Select the approach that fits conventions, minimizes changes, and solves the requirement.

## Step 2: Component Design

For each component: purpose (one sentence), interface (public API), dependencies, data handled.

## Step 3: Data Flow

Trace data from entry to exit: User action → API endpoint → Service → Database → Response → UI update. Identify validation, transformation, persistence, and error handling points.

## Step 4: API Contracts (if applicable)

For each endpoint: METHOD /path, request shape, response shape, status codes, auth requirement.

## Step 5: Database Changes (if applicable)

New tables/columns with types, migration strategy, index considerations, data backfill needs.

## Step 6: Implementation Order

1. Data layer first (models, schemas, migrations)
2. Business logic second (services, utils)
3. API layer third (routes, controllers)
4. UI layer last (components, pages)
5. Tests alongside each layer

## Output

Write to `_workspace/02_architect_design.md` with sections: Approach, Components (table), Data Flow, Files to Create/Modify (table), API Contracts, Database Changes, Trade-off Decisions (table), Implementation Order.
