# 元膳健康网站部署指南 - 自动完成版

## 📋 前置检查

当前项目状态：
- ✅ 代码已准备好
- ✅ Git仓库已初始化
- ✅ 所有文档已完善
- ❌ 需要推送到GitHub
- ❌ 需要在Vercel部署

---

## 🚀 自动部署流程

### 方式一：完全自动化（推荐）

#### 步骤1：准备GitHub账户（1分钟）

1. 确保您有GitHub账号
   - 如果没有，访问：https://github.com/signup（免费注册）

2. 创建个人访问令牌（用于自动推送）
   - 访问：https://github.com/settings/tokens
   - 点击 "Generate new token" → "Generate new token (classic)"
   - Note: 元膳健康部署
   - Expiration: 90 days
   - ✅ 勾选权限：
     - `repo`（完整仓库权限）
     - `workflow`（GitHub Actions）
   - 点击 "Generate token"
   - **重要**：复制生成的令牌（只显示一次）

#### 步骤2：运行部署脚本

**创建自动化部署脚本**：

```powershell
# 自动部署脚本
# 保存为：auto-deploy.ps1

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
```

#### 步骤3：执行脚本

**在PowerShell中运行**：

```powershell
# 1. 进入项目目录
cd "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"

# 2. 运行部署脚本（替换为您的信息）
.\auto-deploy.ps1 -GitHubUsername "你的GitHub用户名" -GitHubToken "刚才复制的令牌"
```

**示例**：
```powershell
.\auto-deploy.ps1 -GitHubUsername "zhangsan" -GitHubToken "ghp_xxxxxxxxxxxxxxxxxxxx"
```

#### 步骤4：在Vercel部署

脚本会自动打开Vercel部署页面，您需要：

1. **登录Vercel**
   - 使用GitHub账号登录
   - 授权Vercel访问GitHub仓库

2. **导入项目**
   - 点击 "Import Git Repository"
   - 选择 `yuanshan-health-website`
   - 点击 "Import"

3. **部署配置**
   - Project Name: `yuanshan-health-website`（自动填充）
   - Framework Preset: "Other"（自动检测）
   - Build Command: 留空（静态网站无需构建）
   - Output Directory: `./`（根目录）
   - 点击 "Deploy"

4. **等待部署**
   - 部署过程约30-60秒
   - 看到 "Congratulations!" 页面表示部署成功

5. **访问网站**
   ```
   https://yuanshan-health-website.vercel.app
   ```

---

### 方式二：手动操作（备用方案）

如果自动脚本遇到问题，可以手动操作：

#### 1. 创建GitHub仓库

访问：https://github.com/new

配置：
- Repository name: `yuanshan-health-website`
- Description: 元膳健康 - AI驱动的智能健康膳食平台
- Public: ✅ 选择公开
- ❌ 不勾选其他选项

#### 2. 推送代码

在PowerShell中：

```powershell
cd "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"

# 添加远程仓库（替换为你的URL）
git remote add origin https://github.com/你的用户名/yuanshan-health-website.git

# 重命名分支
git branch -M main

# 推送代码
git push -u origin main
```

#### 3. Vercel部署

访问：https://vercel.com/new

按照页面提示完成导入和部署。

---

## 📊 部署清单

完成以下所有项：

- [ ] GitHub账号已注册
- [ ] GitHub个人访问令牌已创建
- [ ] 代码已推送到GitHub
- [ ] Vercel账号已注册
- [ ] Vercel项目已创建
- [ ] 部署成功
- [ ] 网站可以访问

---

## 🔧 常见问题

### 问题1：推送失败

**错误信息**：`Authentication failed`

**解决方案**：
1. 检查令牌是否正确
2. 确认令牌有 `repo` 权限
3. 检查网络连接

### 问题2：仓库名称错误

**错误信息**：`Repository not found`

**解决方案**：
1. 确认GitHub用户名正确
2. 确认仓库名称为 `yuanshan-health-website`
3. 确认仓库已创建

### 问题3：Vercel部署失败

**可能原因**：
- GitHub仓库为空
- 网络连接问题
- Vercel配置错误

**解决方案**：
1. 确认GitHub仓库有代码
2. 重新尝试部署
3. 检查Vercel部署日志

---

## 💰 成本说明

| 项目 | 成本 |
|------|------|
| GitHub | 免费 |
| Vercel | 免费 |
| 域名 | 免费（vercel.app） |
| HTTPS | 免费 |
| CDN | 免费 |
| **总计** | **$0/年** |

---

## ⏱️ 时间预算

- 准备GitHub账户和令牌：2分钟
- 运行部署脚本：1分钟
- Vercel部署：2分钟
- **总计**：**5分钟**

---

## 📞 需要帮助？

如果遇到问题：

1. **GitHub文档**：https://docs.github.com
2. **Vercel文档**：https://vercel.com/docs
3. **常见问题**：查看本文档的"常见问题"部分

---

## 🎉 完成！

部署成功后，您可以：

1. ✅ 访问网站：https://yuanshan-health-website.vercel.app
2. ✅ 测试所有功能
3. ✅ 分享网站链接
4. ✅ 收集用户反馈

**现在开始部署吧！5分钟后您的网站就会上线！** 🚀
