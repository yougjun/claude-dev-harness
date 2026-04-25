# E2E Test Patterns (Playwright / Cypress)

## Playwright

### File Structure
- Config: `playwright.config.ts`
- Tests: `tests/` or `e2e/` directory
- Test file: `*.spec.ts`

### Basic Test
```typescript
import { test, expect } from '@playwright/test';

test('user can login', async ({ page }) => {
  await page.goto('/login');
  await page.fill('[name="email"]', 'user@example.com');
  await page.fill('[name="password"]', 'password123');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/dashboard');
  await expect(page.locator('h1')).toContainText('Dashboard');
});
```

### API Testing
```typescript
test('API returns user list', async ({ request }) => {
  const response = await request.get('/api/users');
  expect(response.ok()).toBeTruthy();
  const data = await response.json();
  expect(data.length).toBeGreaterThan(0);
});
```

### Running
```bash
npx playwright test                    # All tests
npx playwright test tests/login.spec.ts # Single file
npx playwright test --headed           # Show browser
npx playwright test --ui               # Interactive UI
```

## Cypress

### Basic Test
```typescript
describe('Login', () => {
  it('should login successfully', () => {
    cy.visit('/login');
    cy.get('[name="email"]').type('user@example.com');
    cy.get('[name="password"]').type('password123');
    cy.get('button[type="submit"]').click();
    cy.url().should('include', '/dashboard');
  });
});
```

### Running
```bash
npx cypress run            # Headless
npx cypress open           # Interactive
```
