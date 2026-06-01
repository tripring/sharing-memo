@echo off
chcp 65001 > nul
echo ================================
echo  Docker で Playwright テスト実行
echo ================================
echo.

:: テスト対象のURLを引数で受け取る（デフォルト: http://host.docker.internal:3000）
set TARGET_URL=%1
if "%TARGET_URL%"=="" set TARGET_URL=http://host.docker.internal:3000

echo 対象URL: %TARGET_URL%
echo.

docker compose run --rm -e BASE_URL=%TARGET_URL% playwright
if %errorlevel% neq 0 (
  echo.
  echo [ERROR] テストが失敗しました。
  pause
  exit /b 1
)

echo.
echo ================================
echo  テスト完了
echo  レポート: playwright-report\index.html
echo ================================
pause
