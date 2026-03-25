# 网站自动检测和通知脚本
# 功能：持续检测网站状态，成功后停止

param(
    [string]$WebsiteUrl = "https://yuanshan-health-website.vercel.app",
    [int]$CheckInterval = 30,  # 检测间隔（秒）
    [int]$MaxAttempts = 60    # 最大尝试次数（30分钟）
)

Write-Host "============================================" -ForegroundColor Green
Write-Host "  网站自动检测工具" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "网站地址: $WebsiteUrl" -ForegroundColor Yellow
Write-Host "检测间隔: $CheckInterval 秒" -ForegroundColor Yellow
Write-Host "最大尝试: $MaxAttempts 次" -ForegroundColor Yellow
Write-Host "预计时间: 约$($MaxAttempts * $CheckInterval / 60) 分钟" -ForegroundColor Yellow
Write-Host ""
Write-Host "开始检测..." -ForegroundColor Cyan
Write-Host ""

$attempt = 0
$success = $false

while ($attempt -lt $MaxAttempts -and -not $success) {
    $attempt++
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    try {
        Write-Host "[$timestamp] 第 $attempt/$MaxAttempts 次尝试..." -ForegroundColor Gray
        
        # 使用Invoke-WebRequest检测网站
        $response = Invoke-WebRequest -Uri $WebsiteUrl -Method Head -TimeoutSec 10 -UseBasicParsing -ErrorAction Stop
        
        # 检查响应状态码
        if ($response.StatusCode -eq 200) {
            $success = $true
            Write-Host ""
            Write-Host "============================================" -ForegroundColor Green
            Write-Host "  网站检测成功！" -ForegroundColor Green
            Write-Host "============================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "访问时间: $timestamp" -ForegroundColor Green
            Write-Host "响应状态: $($response.StatusCode) OK" -ForegroundColor Green
            $responseTime = if ($response.Headers.'Date') { $response.Headers.'Date' } else { $timestamp }
            Write-Host "响应时间: $responseTime" -ForegroundColor Green
            Write-Host "网站地址: $WebsiteUrl" -ForegroundColor Green
            Write-Host "尝试次数: $attempt 次" -ForegroundColor Green
            Write-Host "耗时: 约$($attempt * $CheckInterval / 60) 分钟" -ForegroundColor Green
            Write-Host ""
            Write-Host "现在可以访问网站了！" -ForegroundColor Cyan
            Write-Host ""
            
            # 打开网站
            Start-Process $WebsiteUrl
            
            break
        }
    }
    catch {
        $errorMsg = $_.Exception.Message
        Write-Host "  访问失败: $errorMsg" -ForegroundColor Red
    }
    
    # 如果未成功，等待下一次检测
    if (-not $success -and $attempt -lt $MaxAttempts) {
        Write-Host "  等待 $CheckInterval 秒..." -ForegroundColor Gray
        Start-Sleep -Seconds $CheckInterval
    }
}

if (-not $success) {
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Red
    Write-Host "  检测超时" -ForegroundColor Red
    Write-Host "============================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "已尝试 $attempt 次，网站仍无法访问" -ForegroundColor Red
    Write-Host "建议：" -ForegroundColor Yellow
    Write-Host "1. 检查网络连接" -ForegroundColor Yellow
    Write-Host "2. 访问 Vercel 部署状态页面" -ForegroundColor Yellow
    Write-Host "3. 查看《网站无法访问-解决方案.md》" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
