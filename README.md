# 小新粉丝圈 — Cloudflare Pages 部署指南

## 目录结构
```
fanclub-app/
├── functions/api/        # 后端 API（Cloudflare Functions）
│   ├── posts.js
│   ├── posts/[id].js
│   ├── comments.js
│   ├── users.js
│   ├── events.js
│   └── stats.js
├── public/              # 前端静态文件
│   ├── index.html
│   ├── css/style.css
│   ├── js/app.js
│   └── _routes.json
├── schema.sql           # 数据库建表语句
└── wrangler.toml       # Cloudflare 配置
```

## 部署步骤

### 第一步：准备 GitHub 仓库
1. 注册登录 https://github.com
2. 新建仓库，比如叫 `xiaoxin-fanclub`，选「公开」
3. 把 `fanclub-app/` 目录里的所有文件推送到仓库

### 第二步：Cloudflare 配置
1. 注册登录 https://dash.cloudflare.com（免费账号）
2. 左侧菜单 → **Workers & Pages**
3. 点击「Create Application」→ 选择 **Pages** 标签
4. 连接 GitHub 仓库，选择刚创建的仓库

### 第三步：构建设置
在 Cloudflare Pages 构建设置页面填写：
- **Framework preset**: `None`
- **Build command**: 留空（不需要构建）
- **Build output directory**: `public`
- **Root directory**: `fanclub-app`（如果仓库根目录就是 fanclub-app 则留空）

### 第四步：绑定 D1 数据库
1. 在 Cloudflare 控制台 → **Workers & Pages** → 左侧 **D1**
2. 点击「Create database」，数据库名填 `xiaoxin-fanclub-db`
3. 回到 Pages 项目 → **Settings** → **Functions** → **D1 database bindings**
4. 添加绑定：`Variable name` 填 `DB`，选择刚创建的数据库
5. 重新部署一次

### 第五步：初始化数据库
在 Cloudflare D1 控制台，对数据库执行 `schema.sql` 里的 SQL 语句。

### 第六步：自定义网址（可选）
在 Pages 项目 → **Custom domains** → 添加你的域名。
如果没有域名，默认地址是 `https://项目名.pages.dev`，永久有效。

---

## 本地测试（可选）
```bash
# 安装 Wrangler CLI
npm install -g wrangler

# 登录 Cloudflare
wrangler login

# 本地开发
cd fanclub-app
wrangler pages dev public --d1 DB=xiaoxin-fanclub-db
```

---

## 注意事项
- 图片/封面以 base64 存在数据库中，建议图片不要太大（< 1MB）
- 免费版 D1 限制：每天 500 万行读取、10 万行写入
- 对于粉丝圈规模完全够用
