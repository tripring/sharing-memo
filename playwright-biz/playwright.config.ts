import { defineConfig, devices } from '@playwright/test';
import { defineBddProject } from 'playwright-bdd';

// テスト対象の URL を環境変数 BASE_URL で上書き可能
// 例: BASE_URL=http://localhost:8080 npx playwright test
const BASE_URL = process.env.BASE_URL ?? 'http://localhost:3000';

export default defineConfig({
  fullyParallel: false,
  workers: 1,
  retries: 0,
  reporter: 'html',
  use: {
    baseURL: BASE_URL,
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      ...defineBddProject({
        name: 'bdd',
        features: 'e2e/features/**/*.feature',
        steps: 'e2e/steps/**/*.ts',
      }),
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
