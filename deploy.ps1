# YuanShan Health Auto Deploy Script
# Run this script to deploy to Vercel

Write-Host "========================================"
Write-Host "   YuanShan Health - Auto Deploy"
Write-Host "========================================"
Write-Host ""

# Check git status
Write-Host "[Step 1/3] Checking Git status..."
git status
Write-Host "OK - Git status checked"
Write-Host ""

# Check remote
Write-Host "[Step 2/3] Checking remote repository..."
git remote -v
Write-Host ""

# Push to GitHub
Write-Host "[Step 3/3] Pushing code to GitHub..."
Write-Host "Please wait..."

$pushResult = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS - Code pushed to GitHub!"
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "1. Open Vercel: https://vercel.com/new"
    Write-Host "2. Login with GitHub"
    Write-Host "3. Import: heart-bank/yuanshan-health-website"
    Write-Host "4. Click Deploy"
    Write-Host ""
    Write-Host "Your website will be at:"
    Write-Host "https://yuanshan-health-website.vercel.app"
    Write-Host ""
    
    $openVercel = Read-Host "Open Vercel now? (Y/N)"
    if ($openVercel -eq "Y" -or $openVercel -eq "y") {
        Start-Process "https://vercel.com/new"
    }
} else {
    Write-Host "ERROR - Push failed"
    Write-Host $pushResult
    Write-Host ""
    Write-Host "Please make sure GitHub repository exists:"
    Write-Host "https://github.com/heart-bank/yuanshan-health-website"
}

Write-Host ""
Write-Host "========================================"
Write-Host "   Script completed"
Write-Host "========================================"
