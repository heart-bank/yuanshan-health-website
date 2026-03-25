# 元膳健康网站 - 完整自动化部署脚本
# 此脚本会自动完成所有部署步骤

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername,

    [Parameter(Mandatory=$true)]
    [string]$GitHubToken
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "元膳健康网站 - 完整自动化部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 进入项目目录
$projectPath = "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"
Set-Location $projectPath
Write-Host "✓ 项目目录: $projectPath" -ForegroundColor Green

# 2. 检查Git状态
Write-Host ""
Write-Host "步骤1/6: 检查Git状态..." -ForegroundColor Yellow
$gitStatus = git status --short
if (-not $gitStatus) {
    Write-Host "✓ Git工作区干净" -ForegroundColor Green
} else {
    Write-Host "⚠ 有未提交的更改，正在提交..." -ForegroundColor Yellow
    git add .
    git commit -m "自动部署 - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Write-Host "✓ 已提交更改" -ForegroundColor Green
}

# 3. 配置远程仓库
Write-Host ""
Write-Host "步骤2/6: 配置GitHub远程仓库..." -ForegroundColor Yellow
$repoUrl = "https://${GitHubUsername}:${GitHubToken}@github.com/${GitHubUsername}/yuanshan-health-website.git"

# 移除旧的远程仓库
$remotes = git remote
if ($remotes -match "origin") {
    git remote remove origin
}

# 添加新的远程仓库
git remote add origin $repoUrl
Write-Host "✓ 远程仓库已配置" -ForegroundColor Green

# 4. 重命名分支
Write-Host ""
Write-Host "步骤3/6: 配置分支..." -ForegroundColor Yellow
$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "✓ 分支已重命名为main" -ForegroundColor Green
} else {
    Write-Host "✓ 分支已经是main" -ForegroundColor Green
}

# 5. 推送代码
Write-Host ""
Write-Host "步骤4/6: 推送代码到GitHub..." -ForegroundColor Yellow
git push -u origin main
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 代码已成功推送到GitHub" -ForegroundColor Green
    Write-Host ""
    Write-Host "GitHub仓库地址:" -ForegroundColor Cyan
    Write-Host "https://github.com/${GitHubUsername}/yuanshan-health-website" -ForegroundColor White
} else {
    Write-Host "✗ 推送失败" -ForegroundColor Red
    Write-Host "请检查:" -ForegroundColor Yellow
    Write-Host "1. GitHub用户名是否正确" -ForegroundColor White
    Write-Host "2. 令牌是否有效" -ForegroundColor White
    Write-Host "3. 网络连接是否正常" -ForegroundColor White
    exit 1
}

# 6. 等待3秒
Write-Host ""
Write-Host "步骤5/6: 等待GitHub仓库创建..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# 7. 打开Vercel部署页面
Write-Host ""
Write-Host "步骤6/6: 打开Vercel部署页面..." -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "下一步：在Vercel上部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Vercel会自动打开" -ForegroundColor White
Write-Host "2. 使用GitHub账号登录（您的心bank账号）" -ForegroundColor White
Write-Host "3. 点击 'Import Git Repository'" -ForegroundColor White
Write-Host "4. 选择仓库: yuanshan-health-website" -ForegroundColor White
Write-Host "5. 点击 'Deploy' 按钮" -ForegroundColor White
Write-Host "6. 等待30-60秒" -ForegroundColor White
Write-Host ""
Write-Host "您的网站地址:" -ForegroundColor Green
Write-Host "https://yuanshan-health-website.vercel.app" -ForegroundColor Cyan
Write-Host ""

# 自动打开Vercel
Start-Process "https://vercel.com/new"

Write-Host "✓ Vercel部署页面已打开" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "部署完成！🎉" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "后续步骤：" -ForegroundColor Yellow
Write-Host "1. 在Vercel完成部署（2分钟）" -ForegroundColor White
Write-Host "2. 访问网站测试所有功能" -ForegroundColor White
Write-Host "3. 如有问题，随时联系我修复" -ForegroundColor White
Write-Host ""
