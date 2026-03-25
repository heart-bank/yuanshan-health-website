# 元膳健康官网 - 一键部署脚本
# 使用方法：在PowerShell中运行 .\deploy.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  元膳健康官网 - Vercel自动部署工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Git是否安装
Write-Host "[1/6] 检查Git安装..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✓ Git已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git未安装！请先安装Git：https://git-scm.com/downloads" -ForegroundColor Red
    exit 1
}

# 进入项目目录
$projectPath = "d:/hgp/胡高鹏创业思路/重庆元膳健康科技有限责任公司文件"
Set-Location $projectPath
Write-Host "✓ 已进入项目目录: $projectPath" -ForegroundColor Green
Write-Host ""

# 检查Git仓库状态
Write-Host "[2/6] 检查Git仓库状态..." -ForegroundColor Yellow
$gitStatus = git status 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Git仓库已初始化" -ForegroundColor Green
} else {
    Write-Host "✗ Git仓库未初始化！正在初始化..." -ForegroundColor Yellow
    git init
    Write-Host "✓ Git仓库初始化完成" -ForegroundColor Green
}
Write-Host ""

# 检查是否有GitHub远程仓库
Write-Host "[3/6] 检查远程仓库..." -ForegroundColor Yellow
$remoteUrl = git remote get-url origin 2>$null
if ($remoteUrl) {
    Write-Host "✓ 已配置远程仓库: $remoteUrl" -ForegroundColor Green
} else {
    Write-Host "✗ 未配置远程仓库" -ForegroundColor Red
    Write-Host ""
    Write-Host "请手动配置GitHub仓库：" -ForegroundColor Yellow
    Write-Host "1. 访问 https://github.com/new 创建新仓库" -ForegroundColor White
    Write-Host "2. 复制你的仓库URL（如：https://github.com/用户名/yuanshan-health-website.git）" -ForegroundColor White
    Write-Host ""
    $repoUrl = Read-Host "请输入GitHub仓库URL"
    
    if ($repoUrl) {
        git remote add origin $repoUrl
        Write-Host "✓ 远程仓库配置完成" -ForegroundColor Green
    } else {
        Write-Host "✗ 未配置远程仓库，部署终止" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# 添加并提交代码
Write-Host "[4/6] 提交代码到本地仓库..." -ForegroundColor Yellow
git add .
$commitMessage = "Auto deploy - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commitMessage --allow-empty
Write-Host "✓ 代码已提交" -ForegroundColor Green
Write-Host ""

# 推送代码到GitHub
Write-Host "[5/6] 推送代码到GitHub..." -ForegroundColor Yellow
Write-Host "这可能需要几分钟，请耐心等待..." -ForegroundColor White
Write-Host ""

try {
    git push -u origin master 2>&1 | ForEach-Object {
        Write-Host $_
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ 代码已成功推送到GitHub" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "✗ 推送失败！请检查：" -ForegroundColor Red
        Write-Host "  1. GitHub仓库URL是否正确" -ForegroundColor White
        Write-Host "  2. 是否有GitHub访问权限" -ForegroundColor White
        Write-Host "  3. 网络连接是否正常" -ForegroundColor White
        exit 1
    }
} catch {
    Write-Host "✗ 推送失败！" -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}
Write-Host ""

# 完成提示
Write-Host "[6/6] 部署准备完成！" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  下一步操作" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 访问 Vercel: https://vercel.com/new" -ForegroundColor Green
Write-Host "2. 登录GitHub并选择你的仓库" -ForegroundColor Green
Write-Host "3. 点击Deploy按钮" -ForegroundColor Green
Write-Host "4. 等待30-60秒，网站即可访问！" -ForegroundColor Green
Write-Host ""
Write-Host "详细部署指南请查看：Vercel自动部署指南.md" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 打开浏览器
Write-Host "是否现在打开Vercel部署页面？(Y/N)" -ForegroundColor Yellow
$response = Read-Host

if ($response -eq "Y" -or $response -eq "y") {
    Start-Process "https://vercel.com/new"
    Write-Host "✓ 已打开浏览器" -ForegroundColor Green
}

Write-Host "部署脚本执行完成！" -ForegroundColor Green
