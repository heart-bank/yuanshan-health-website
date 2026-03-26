@echo off
chcp 65001 >nul
echo ====================================================
echo   元膳健康网站 - 推送到Gitee脚本
echo ====================================================
echo.

:: 请修改这里的用户名为您的Gitee用户名
set GITEE_USERNAME=YOUR_GITEE_USERNAME
set REPO_NAME=yuanshan

if "%GITEE_USERNAME%"=="YOUR_GITEE_USERNAME" (
    echo [错误] 请先编辑此文件，将 YOUR_GITEE_USERNAME 替换为您的Gitee用户名！
    echo.
    echo 例如：如果您的Gitee用户名是 yuanshan2026
    echo 则将第8行改为：set GITEE_USERNAME=yuanshan2026
    echo.
    pause
    exit /b 1
)

cd /d "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"

echo [1/3] 检查Gitee远端配置...
git remote get-url gitee >nul 2>&1
if %errorlevel% neq 0 (
    echo 添加Gitee远端...
    git remote add gitee https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%.git
    echo 已添加Gitee远端: https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%.git
) else (
    echo Gitee远端已配置
)

echo.
echo [2/3] 推送代码到Gitee...
git push gitee main
if %errorlevel% neq 0 (
    echo.
    echo [错误] 推送失败！请检查：
    echo 1. Gitee仓库是否已创建
    echo 2. 用户名是否正确
    echo 3. 网络是否正常
    pause
    exit /b 1
)

echo.
echo [3/3] 推送成功！
echo.
echo ====================================================
echo   下一步：开启Gitee Pages
echo ====================================================
echo.
echo 1. 访问：https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%/pages
echo 2. 选择分支：main
echo 3. 点击"启动"按钮
echo 4. 等待1-2分钟
echo 5. 网站地址：https://%GITEE_USERNAME%.gitee.io/%REPO_NAME%/
echo.
echo 正在打开Gitee仓库页面...
start https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%
echo.
pause
