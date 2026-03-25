# 元膳健康官网 - Vercel自动部署指南

## 🚀 快速开始（5分钟部署）

本指南将帮助您将元膳健康官网免费部署到Vercel，获得：
- ✅ 免费SSL证书（HTTPS）
- ✅ 全球CDN加速
- ✅ 自动部署
- ✅ 99.99%可用性

---

## 📋 前置要求

1. **GitHub账户**（免费）：https://github.com/signup
2. **Vercel账户**（免费）：https://vercel.com/signup

---

## 第一步：推送代码到GitHub

### 1.1 创建GitHub仓库

1. 访问：https://github.com/new
2. 仓库名称：`yuanshan-health-website`
3. 设置为**公开仓库**（Public）
4. 不要勾选"Initialize this repository with a README"
5. 点击"Create repository"

### 1.2 推送代码

打开PowerShell，执行以下命令：

```powershell
# 进入项目目录
cd "d:/hgp/胡高鹏创业思路/重庆元膳健康科技有限责任公司文件"

# 添加GitHub远程仓库（替换YOUR_USERNAME为你的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/yuanshan-health-website.git

# 推送代码到GitHub
git branch -M main
git push -u origin main
```

**示例**（如果你的GitHub用户名是`hugao123`）：
```powershell
git remote add origin https://github.com/hugao123/yuanshan-health-website.git
git branch -M main
git push -u origin main
```

---

## 第二步：部署到Vercel

### 2.1 导入项目到Vercel

1. 访问：https://vercel.com/new
2. 登录GitHub账户
3. 点击"Import Git Repository"
4. 选择刚创建的`yuanshan-health-website`仓库

### 2.2 配置部署设置

Vercel会自动检测项目类型，配置如下：

**项目设置**：
- **Framework Preset**: Other（其他）
- **Root Directory**: `./`（保持默认）
- **Build Command**: （留空）
- **Output Directory**: `./`（保持默认）

**点击"Deploy"按钮**

### 2.3 等待部署完成

- 部署通常需要30-60秒
- 完成后会显示：🎉 Congratulations!

### 2.4 访问网站

Vercel会提供一个免费域名，格式为：
```
https://yuanshan-health-website.vercel.app
```

---

## 第三步：配置自定义域名（可选）

### 3.1 购买域名

推荐域名注册商（中国）：
- **阿里云**：https://wanwang.aliyun.com
- **腾讯云**：https://dnspod.cloud.tencent.com
- **Cloudflare**（推荐，免费DNS）：https://dash.cloudflare.com

### 3.2 在Vercel添加域名

1. 访问：https://vercel.com/dashboard
2. 选择项目：`yuanshan-health-website`
3. 点击"Settings" → "Domains"
4. 输入你的域名（例如：`yuanshan.com`）
5. 点击"Add"

### 3.3 配置DNS解析

Vercel会提供CNAME记录，在域名注册商添加：

| 类型 | 名称 | 值 |
|------|------|-----|
| CNAME | www | cname.vercel-dns.com |

### 3.4 配置根域名（A记录）

| 类型 | 名称 | 值 |
|------|------|-----|
| A | @ | 76.76.21.21 |

---

## 第四步：更新网站链接

部署成功后，需要更新以下文件中的链接：

### 4.1 更新网站内链

在以下HTML文件中，将所有相对链接改为绝对链接：

- `元膳健康官网首页（升级版）.html`
- `快速健康评估.html`
- `AI健康膳食报告系统_pro.html`
- `关于我们.html`
- `FAQ.html`

**示例**：
```html
<!-- 修改前 -->
<a href="快速健康评估.html">快速评估</a>

<!-- 修改后 -->
<a href="/快速健康评估.html">快速评估</a>
```

### 4.2 添加favicon（网站图标）

创建`favicon.ico`文件，放在项目根目录，或在`<head>`标签中添加：

```html
<link rel="icon" href="/favicon.ico" type="image/x-icon">
```

---

## 🎉 部署完成！

您的网站现在已经在线访问：

- **测试网址**：https://yuanshan-health-website.vercel.app
- **自定义域名**：https://your-domain.com（如果已配置）

---

## 🔧 常见问题

### Q1: 部署失败怎么办？

**A**: 检查以下内容：
- 确保GitHub仓库已正确推送
- 检查Vercel日志（在Dashboard查看）
- 确保文件路径正确（根目录包含HTML文件）

### Q2: 如何更新网站？

**A**: 只需推送新代码到GitHub，Vercel会自动部署：

```powershell
git add .
git commit -m "更新内容"
git push
```

### Q3: 如何查看访问统计？

**A**: Vercel提供免费的分析工具：
1. 访问项目Dashboard
2. 点击"Analytics"
3. 查看访问量、页面浏览量等数据

### Q4: 免费套餐有限制吗？

**A**: Vercel免费套餐包含：
- ✅ 无限带宽
- ✅ 100GB/月流量
- ✅ 自动HTTPS
- ✅ 全球CDN
- ✅ 100个团队成员
- ❌ 无服务器功能（本项目不需要）

### Q5: 如何添加Google Analytics？

**A**: 在每个HTML文件的`</head>`标签前添加：

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

---

## 📞 获取帮助

- **Vercel文档**：https://vercel.com/docs
- **Vercel支持**：https://vercel.com/support
- **GitHub文档**：https://docs.github.com

---

## ✅ 部署检查清单

部署完成后，请检查以下项目：

- [ ] 网站首页可以正常访问
- [ ] 所有页面链接正常工作
- [ ] HTTPS证书已生效（浏览器显示锁形图标）
- [ ] 快速健康评估功能正常
- [ ] 完整版评估系统正常
- [ ] 管理员后台可以登录
- [ ] 用户注册和登录正常
- [ ] 移动端显示正常
- [ ] 页面加载速度< 3秒

---

## 🚀 下一步优化建议

1. **配置自定义域名** - 提升品牌形象
2. **添加Google Analytics** - 了解用户行为
3. **优化SEO** - 提高搜索引擎排名
4. **添加在线客服** - 提升用户体验
5. **配置CDN缓存** - 加速访问速度

---

**部署成功！🎉**

如有问题，请联系技术支持。
