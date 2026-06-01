#!/bin/bash
set -e

TARGET_URL="${1:-http://host.docker.internal:3000}"

echo "================================"
echo " Docker で Playwright テスト実行"
echo "================================"
echo ""
echo "対象URL: $TARGET_URL"
echo ""

BASE_URL=$TARGET_URL docker compose run --rm playwright

echo ""
echo "================================"
echo " テスト完了"
echo " レポート: playwright-report/index.html"
echo "================================"
