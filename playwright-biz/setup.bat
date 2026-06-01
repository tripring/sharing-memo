@echo off
chcp 65001 > nul
echo ================================
echo  Playwright セットアップ
echo ================================
echo.

:: Node.js チェック
node -v > nul 2>&1
if %errorlevel% neq 0 (
  echo [ERROR] Node.js がインストールされていません。
  echo https://nodejs.org からインストールしてください。
  pause
  exit /b 1
)
echo [OK] Node.js:
node -v

:: npm install
echo.
echo [1/2] パッケージをインストール中...
call npm install
if %errorlevel% neq 0 (
  echo [ERROR] npm install に失敗しました。
  pause
  exit /b 1
)

:: Playwright ブラウザインストール
echo.
echo [2/2] Playwright ブラウザをインストール中（少し時間がかかります）...
call npx playwright install chromium
if %errorlevel% neq 0 (
  echo [ERROR] Playwright ブラウザのインストールに失敗しました。
  pause
  exit /b 1
)

echo.
echo ================================
echo  セットアップ完了！
echo.
echo  テスト実行方法:
echo    npm test
echo.
echo  対象URLを変更する場合:
echo    set BASE_URL=http://localhost:8080
echo    npm test
echo ================================
pause
