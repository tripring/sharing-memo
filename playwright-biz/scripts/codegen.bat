@echo off
chcp 65001 > nul
:: テスト対象のURLを引数で受け取る（デフォルト: http://localhost:3000）
set TARGET_URL=%1
if "%TARGET_URL%"=="" set TARGET_URL=http://localhost:3000

echo 対象URL: %TARGET_URL%
echo ブラウザで操作すると右側にコードが生成されます。
echo 生成されたコードをコピーして AI に渡してください。
echo.
npx playwright codegen %TARGET_URL%
