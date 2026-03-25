# 元膳健康项目 - 自动部署脚本
# 使用说明：在PowerShell中运行此脚本，按照提示完成部署

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   元膳健康项目 - 自动部署脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 步骤1：检查Git状态
Write-Host "[步骤 1/4] 检查Git状态..." -ForegroundColor Yellow
git status
Write-Host "✅ Git状态检查完成" -ForegroundColor Green
Write-Host ""

# 步骤2：检查远程仓库
Write-Host "[步骤 2/4] 检查远程仓库配置..." -ForegroundColor Yellow
git remote -v
Write-Host ""

# 步骤3：提示用户创建GitHub仓库
Write-Host "[步骤 3/4] 创建GitHub仓库" -ForegroundColor Yellow
Write-Host "请按照以下步骤操作：" -ForegroundColor White
Write-Host "1. 点击此链接打开GitHub：" -ForegroundColor Cyan
Write-Host "   https://github.com/new" -ForegroundColor Blue
Write-Host ""
Write-Host "2. 填写以下信息：" -ForegroundColor White
Write-Host "   - Repository name: yuanshan-health-website" -ForegroundColor Yellow
Write-Host "   - 选择 Public（公开）" -ForegroundColor Yellow
Write-Host "   - 不要勾选其他选项（Add README、.gitignore等）" -ForegroundColor Yellow
Write-Host "   - 点击 'Create repository'" -ForegroundColor Yellow
Write-Host ""

# 检查用户是否已完成
$repoExists = Read-Host "已完成GitHub仓库创建？(Y/N)"
if ($repoExists -ne "Y" -and $repoExists -ne "y") {
    Write-Host "请先完成GitHub仓库创建，然后重新运行脚本" -ForegroundColor Red
    exit
}

# 步骤4：推送代码
Write-Host ""
Write-Host "[步骤 4/4] 推送代码到GitHub..." -ForegroundColor Yellow
Write-Host "正在推送代码，请稍候..." -ForegroundColor White

$pushResult = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 代码推送成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "   代码推送成功！下一步：Vercel部署" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "请按照以下步骤在Vercel部署：" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. 点击此链接打开Vercel：" -ForegroundColor Cyan
    Write-Host "   https://vercel.com/new" -ForegroundColor Blue
    Write-Host ""
    Write-Host "2. 登录您的GitHub账号" -ForegroundColor White
    Write-Host ""
    Write-Host "3. 点击 'Import Git Repository'" -ForegroundColor White
    Write-Host ""
    Write-Host "4. 选择 'heart-bank/yuanshan-health-website'" -ForegroundColor White
    Write-Host ""
    Write-Host "5. 点击 'Deploy' 按钮" -ForegroundColor White
    Write-Host ""
    Write-Host "6. 等待30-60秒" -ForegroundColor White
    Write-Host ""
    Write-Host "部署成功后，访问：" -ForegroundColor Green
    Write-Host "   https://yuanshan-health-website.vercel.app" -ForegroundColor Blue
    Write-Host ""
    Write-Host "总成本：$0/年（完全免费）" -ForegroundColor Green
    Write-Host ""
    
    # 询问是否自动打开Vercel
    $openVercel = Read-Host "是否自动打开Vercel部署页面？(Y/N)"
    if ($openVercel -eq "Y" -or $openVercel -eq "y") {
        Start-Process "https://vercel.com/new"
    }
} else {
    Write-Host "❌ 代码推送失败" -ForegroundColor Red
    Write-Host "错误信息：" -ForegroundColor Red
    Write-Host $pushResult -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因：" -ForegroundColor Yellow
    Write-Host "1. GitHub仓库还没有创建" -ForegroundColor White
    Write-Host "2. 仓库名称不匹配（必须是 yuanshan-health-website）" -ForegroundColor White
    Write-Host "3. 网络连接问题" -ForegroundColor White
    Write-Host ""
    Write-Host "请检查后重新运行脚本" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   脚本执行完成" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
