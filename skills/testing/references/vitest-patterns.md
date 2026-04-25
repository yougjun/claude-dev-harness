# Vitest/Jest Patterns

## File Structure
- Test files: {component}.test.tsx or __tests__/{component}.test.tsx
- Match source: src/hooks/useFloor1.ts → src/hooks/__tests__/useFloor1.test.ts

## Component Testing
```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'

describe('UserProfile', () => {
  it('renders user name', () => {
    render(<UserProfile name="Test User" />)
    expect(screen.getByText('Test User')).toBeInTheDocument()
  })

  it('calls onEdit when clicked', async () => {
    const onEdit = vi.fn()
    render(<UserProfile name="Test" onEdit={onEdit} />)
    await fireEvent.click(screen.getByRole('button', { name: /edit/i }))
    expect(onEdit).toHaveBeenCalledOnce()
  })
})
```

## Hook Testing
```typescript
import { renderHook, act } from '@testing-library/react'
import { useCounter } from './useCounter'

it('increments counter', () => {
  const { result } = renderHook(() => useCounter())
  act(() => result.current.increment())
  expect(result.current.count).toBe(1)
})
```

## Running
```bash
npx vitest run                    # Single run
npx vitest run src/hooks/         # Directory
npx vitest --coverage             # With coverage
```
