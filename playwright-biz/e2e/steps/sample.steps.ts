import { createBdd } from 'playwright-bdd';
import { expect } from '@playwright/test';

const { Given, Then } = createBdd();

Given('トップページを開いている', async ({ page }) => {
  await page.goto('/');
});

Then('ページタイトルが表示される', async ({ page }) => {
  await expect(page).toHaveTitle(/.+/);
});
