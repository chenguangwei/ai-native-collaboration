# 🧑‍💻 项目导航图

> 此文件由 AI 的 `/document-release` 自动维护

## 项目概览

| 属性 | 值 |
|------|-----|
| 项目名称 | [项目名称] |
| 类型 | 多平台应用 (Web + Mobile + API) |
| 创建时间 | 2026-03-23 |
| AI 框架版本 | v1.0 |

## 目录结构

```
.
├── CLAUDE.md              # 🤖 AI 灵魂中枢
├── README.md              # 🧑‍💻 项目导航图
├── .gitignore             # Git 忽略配置
│
├── /rules                 # 📜 核心准则 (Layer 0)
├── /commands              # ⚡ Slash Commands (Layer 0)
├── /agents                # 🎭 虚拟角色 (Layer 0)
├── /custom-skills                # 🛠️ 技能工具箱 (Layer 0)
│
├── /memory                # 💾 记忆体 (Layer 1)
├── /docs                  # 📖 知识库 (Layer 2)
│
├── /src                   # ⌨️ 代码开发区 (Layer 3)
│   ├── /frontend          # 前端应用
│   └── /backend           # 后端服务
│
├── /tests                 # 🕵️ 自动化测试 (Layer 3)
│   ├── /e2e_browser       # 端到端测试
│   ├── /api_integration  # 接口集成测试
│   └── /unit             # 单元测试
│
└── /ops                   # ☁️ 基础设施 (Layer 3)
    ├── docker-compose.yml
    ├── /k8s
    └── release-checklists.md
```

## 快速开始

### AI 交互

```bash
# 唤醒产品思维
/planceo

# 唤醒架构师思维
/plan-architect

# 代码审查
/review

# 自动化测试
/qa

# 发布检查
/ship

# 排障模式
/debug

# 复盘
/retro
```

### 开发环境

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 运行测试
npm test
```

## Git Sparse Checkout

> 不同岗位只拉取自己关注的目录，不影响 push/merge

### 方法一：克隆时指定（推荐）

```bash
# 1. 浅克隆 + sparse-checkout
git clone --depth 1 --sparse https://github.com/your/repo.git

# 2. 进入目录
cd repo

# 3. 设置要拉取的目录
git sparse-checkout set src/backend docs/03_architecture docs/05_ops
```

### 方法二：先克隆再配置

```bash
# 1. 普通克隆
git clone https://github.com/your/repo.git

# 2. 进入目录
cd repo

# 3. 初始化 sparse-checkout
git sparse-checkout init --cone

# 4. 设置目录
git sparse-checkout set src/backend docs/03_architecture
```

### 方法三：一步到位

```bash
# 克隆同时配置
git clone --depth 1 --sparse --branch main \
  --config core.sparseCheckout=true \
  https://github.com/your/repo.git

cd repo

# 编辑 sparse-checkout 文件
echo "src/backend" >> .git/info/sparse-checkout
echo "docs/03_architecture" >> .git/info/sparse-checkout
git checkout
```

### 各方法对比

| 方法 | 优点 | 缺点 |
|------|------|------|
| 方法一 | 快速，少下载 | 需要 shallow clone |
| 方法二 | 简单直观 | 先下载全部再过滤 |
| 方法三 | 一步到位 | 命令较复杂 |

### 团队配置示例

```bash
# 后端工程师
git sparse-checkout set src/backend docs/03_architecture docs/05_ops memory

# 前端工程师
git sparse-checkout set src/frontend docs/02_design docs/04_qa memory

# 产品经理
git sparse-checkout set docs memory

# 运维工程师
git sparse-checkout set docs/05_ops ops memory
```

### 常用命令

```bash
# 查看当前配置
git sparse-checkout list

# 添加新目录（保留原有配置）
git sparse-checkout add src/frontend

# 取消 sparse-checkout，恢复全部文件
git sparse-checkout disable
```

### 注意事项

- Sparse Checkout 只控制**工作目录显示内容**
- 不影响 `git push`、`git merge`、`git pull` 等操作
- 本地 `.git` 仓库是完整的

---

## 文档索引

- [规则手册](/rules/)
- [命令参考](/commands/)
- [API 文档](/docs/03_architecture/api_specs.md)
- [数据库结构](/docs/03_architecture/db_schema.md)
- [测试用例](/docs/04_qa/test_cases.md)

---

*最后更新: 2026-03-23 by Claude Code*
