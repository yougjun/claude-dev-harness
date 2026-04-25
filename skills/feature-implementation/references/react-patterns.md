# React/TypeScript Implementation Patterns

## React Components
- Functional components with hooks (no class components)
- Custom hooks for shared stateful logic (use{Domain}.ts)
- Props interface defined above component
- Destructure props in function signature

## State Management
- Zustand for client state (if project uses it)
- React Query / TanStack Query for server state
- Avoid prop drilling

## TypeScript
- Strict mode: no any unless absolutely necessary
- Interface for object shapes, type for unions/intersections
- Utility types: Partial<T>, Pick<T, K>, Omit<T, K>

## Next.js
- App Router: app/ directory with page.tsx, layout.tsx
- Pages Router: pages/ directory with default exports
- Server components by default, 'use client' only when needed

## Vite
- vite.config.ts for configuration
- Environment variables: import.meta.env.VITE_*
- Code splitting: React.lazy() + Suspense

## UI Libraries
- Follow the project's existing component library patterns
- If no library: use native HTML + CSS modules or styled-components
- If a library exists (MUI, Ant Design, Chakra, etc.): match its usage patterns
