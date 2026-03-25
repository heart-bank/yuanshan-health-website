@echo off
chcp 65001 >nul
echo ========================================
echo    元膳健康 - 一键部署
echo ========================================
echo.
echo 正在准备部署...
echo.

cd /d "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"

echo [1/4] 检查Git状态...
git status
echo.
echo OK - Git状态检查完成
echo.

echo [2/4] 检查远程仓库...
git remote -v
echo.

echo [3/4] 推送代码到GitHub...
echo 如果提示输入用户名，请输入: heart-bank
echo 如果提示输入密码，请输入您的GitHub令牌
echo.
git push -u origin main
echo.

if %errorlevel% equ 0 (
    echo OK - 代码推送成功！
    echo.
    echo [4/4] 打开Vercel部署页面...
    start https://vercel.com/new
    echo.
    echo ========================================
    echo    部署成功！
    echo ========================================
    echo.
    echo 下一步：
    echo 1. Vercel会自动打开
    echo 2. 使用GitHub账号登录
    echo 3. 导入: heart-bank/yuanshan-health-website
    echo 4. 点击Deploy
    echo 5. 等待30-60秒
    echo.
    echo 您的网站地址：
    echo https://yuanshan-health-website.vercel.app
    echo.
) else (
    echo ERROR - 推送失败
    echo.
    echo 请确保GitHub仓库已创建：
    echo https://github.com/heart-bank/yuanshan-health-website
    echo.
    echo 创建仓库步骤：
    echo 1. 访问: https://github.com/new
    echo 2. Repository name: yuanshan-health-website
    echo 3. Public: 选择公开
    echo 4. 点击Create repository
    echo 5. 重新运行此脚本
    echo.
)

echo ========================================
echo 按任意键关闭...
pause >nul
