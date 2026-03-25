# 元膳健康网站 - 自动部署脚本
# 使用方法：.\auto-deploy.ps1 -GitHubUsername "你的用户名" -GitHubToken "你的令牌"

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername,
    
    [Parameter(Mandatory=$true)]
    [string]$GitHubToken
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "元膳健康网站 - 自动部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 进入项目目录
$projectPath = "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"
Set-Location $projectPath
Write-Host "✓ 项目目录: $projectPath" -ForegroundColor Green

# 2. 检查Git状态
Write-Host ""
Write-Host "检查Git状态..." -ForegroundColor Yellow
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
Write-Host "配置GitHub远程仓库..." -ForegroundColor Yellow
$repoUrl = "https://${GitHubUsername}:${GitHubToken}@github.com/${GitHubUsername}/yuanshan-health-website.git"

# 移除旧的远程仓库（如果存在）
$remotes = git remote
if ($remotes -match "origin") {
    git remote remove origin
}

# 添加新的远程仓库
git remote add origin $repoUrl
Write-Host "✓ 远程仓库已配置" -ForegroundColor Green

# 4. 重命名分支为main
Write-Host ""
Write-Host "配置分支..." -ForegroundColor Yellow
$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "✓ 分支已重命名为main" -ForegroundColor Green
} else {
    Write-Host "✓ 分支已经是main" -ForegroundColor Green
}

# 5. 推送到GitHub
Write-Host ""
Write-Host "推送代码到GitHub..." -ForegroundColor Yellow
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

# 6. 打开Vercel部署页面
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "下一步：在Vercel上部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 访问 Vercel:" -ForegroundColor Yellow
Write-Host "   https://vercel.com/new" -ForegroundColor White
Write-Host ""
Write-Host "2. 使用GitHub账号登录" -ForegroundColor White
Write-Host ""
Write-Host "3. 点击 'Import Git Repository'" -ForegroundColor White
Write-Host ""
Write-Host "4. 选择仓库: yuanshan-health-website" -ForegroundColor White
Write-Host ""
Write-Host "5. 点击 'Deploy' 按钮" -ForegroundColor White
Write-Host ""
Write-Host "6. 等待30-60秒，部署完成！" -ForegroundColor Green
Write-Host ""
Write-Host "您的网站地址:" -ForegroundColor Green
Write-Host "https://yuanshan-health-website.vercel.app" -ForegroundColor Cyan
Write-Host ""

# 自动打开Vercel部署页面
Start-Process "https://vercel.com/new"

Write-Host "✓ 正在打开Vercel部署页面..." -ForegroundColor Green
Write-Host ""
Write-Host "部署完成！🎉" -ForegroundColor Green
