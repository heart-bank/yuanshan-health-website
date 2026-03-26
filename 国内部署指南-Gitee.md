# 🇨🇳 元膳健康网站 - 国内部署指南（Gitee Pages）

> **问题分析**：Vercel（vercel.app）在中国大陆被GFW封锁，无法直接访问。
> **解决方案**：使用 Gitee Pages（国内完全可访问，免费）。

---

## ✅ 当前状态

| 项目 | 状态 | 地址 |
|------|------|------|
| 本地服务器 | ✅ 正常运行 | http://localhost:8080 |
| GitHub仓库 | ✅ 代码完整 | https://github.com/heart-bank/yuanshan-health-website |
| Vercel部署 | ❌ 国内无法访问 | ~~https://yuanshan-health-website.vercel.app~~ |
| **Gitee Pages** | **⏳ 待配置** | **https://[用户名].gitee.io/yuanshan** |

---

## 🚀 Gitee Pages 部署步骤（约10分钟）

### 步骤1：注册Gitee账号（2分钟）

1. 打开浏览器，访问：**https://gitee.com/signup**
2. 填写信息注册（手机号或邮箱）
3. 完成手机验证
4. **记录您的用户名**（这将是网址的一部分）

---

### 步骤2：创建Gitee仓库（1分钟）

1. 登录Gitee后，点击右上角 **"+"** → **"新建仓库"**
2. 填写信息：
   - **仓库名称**：`yuanshan`（建议）或 `yuanshan-health`
   - **仓库描述**：元膳健康科技官网
   - **是否公开**：选择 **"公开"**（Gitee Pages要求公开仓库）
   - 不勾选"使用Readme文件初始化仓库"
3. 点击 **"创建仓库"**

---

### 步骤3：推送代码到Gitee（1分钟）

打开命令提示符（CMD），执行以下命令：

```batch
cd "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"

# 添加Gitee为远端（替换YOUR_USERNAME为您的Gitee用户名）
git remote add gitee https://gitee.com/YOUR_USERNAME/yuanshan.git

# 推送代码
git push gitee main
```

**例如：** 如果您的Gitee用户名是 `yuanshan2026`，则命令为：
```
git remote add gitee https://gitee.com/yuanshan2026/yuanshan.git
git push gitee main
```

---

### 步骤4：开启Gitee Pages（2分钟）

1. 在Gitee仓库页面，点击上方菜单 **"服务"** → **"Gitee Pages"**
2. 配置：
   - **部署分支**：main
   - **部署目录**：/（根目录）
   - **强制使用HTTPS**：建议勾选
3. 点击 **"启动"**
4. 等待约1-2分钟，出现绿色成功提示

---

### 步骤5：访问网站（完成！）

部署成功后，您的网站地址为：

```
https://YOUR_USERNAME.gitee.io/yuanshan/
```

例如：`https://yuanshan2026.gitee.io/yuanshan/`

---

## 📱 测试建议

部署后，建议在以下设备测试：
- ✅ 电脑浏览器（Chrome/Edge）
- ✅ 手机浏览器（微信内置浏览器、Safari）
- ✅ 不同网络（WiFi、4G/5G）

---

## ⚡ 快速推送脚本

将以下内容保存为 `push-to-gitee.bat`，替换YOUR_USERNAME后双击运行：

```batch
@echo off
cd /d "d:\hgp\胡高鹏创业思路\重庆元膳健康科技有限责任公司文件"
git remote add gitee https://gitee.com/YOUR_USERNAME/yuanshan.git
git push gitee main
echo.
echo 推送完成！请去Gitee仓库开启Pages服务。
pause
```

---

## 🔄 后续更新

每次更新网站内容后，运行：
```
git add .
git commit -m "Update website"
git push gitee main
```

然后在Gitee Pages页面点击 **"更新"** 按钮即可。

---

## 💡 注意事项

1. **Gitee Pages免费版**：每次更新后需要手动点击"更新"按钮
2. **Gitee Pages付费版（Pro）**：支持自动部署，约9.9元/月
3. **自定义域名**：可以绑定自己的域名（如 www.yuanshan.com）

---

## 📊 国内各平台对比

| 平台 | 访问速度 | 费用 | 自动部署 | 自定义域名 |
|------|---------|------|---------|----------|
| **Gitee Pages** | ⭐⭐⭐⭐⭐ | 免费 | 手动刷新 | 需付费 |
| 阿里云OSS | ⭐⭐⭐⭐⭐ | ~0.5元/月 | 手动上传 | 支持 |
| 腾讯云COS | ⭐⭐⭐⭐⭐ | ~0.5元/月 | 手动上传 | 支持 |
| 腾讯云CloudBase | ⭐⭐⭐⭐⭐ | 免费额度 | CI/CD | 支持 |
| Vercel | 国内封锁 | 免费 | 自动 | 支持 |

**推荐**：先用Gitee Pages（完全免费），后期可以迁移到腾讯云/阿里云。

---

*最后更新：2026-03-26*
