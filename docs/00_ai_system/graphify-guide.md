# Graphify 知识图谱工具使用手册

> 将项目文档、代码、论文、截图转化为可交互知识图谱——揭示文件之间隐藏的关联。

---

## 一、Graphify 是什么

Graphify 是集成在 Claude Code 中的 `/graphify` 技能（来自 [github.com/safishamsi/graphify](https://github.com/safishamsi/graphify)）。它通过两阶段管道处理你的工程目录：

1. **AST 结构提取**（无需 LLM）：解析源代码，识别类、函数、导入、调用链
2. **语义提取**（Claude 并行 subagent）：分析文档、论文、图片，抽取概念与关系

两阶段结果合并为 [NetworkX](https://networkx.org/) 图，经 Leiden 社区检测算法聚类，最终输出：

| 产物 | 说明 |
|------|------|
| `graphify-out/graph.html` | 可交互 HTML 图谱（浏览器直接打开）|
| `graphify-out/graph.json` | GraphRAG 格式 JSON（跨会话持久查询）|
| `graphify-out/GRAPH_REPORT.md` | 审计报告（God 节点、惊喜连接、建议问题）|

**核心差异**：代码走本地 AST，不发送到模型；只有文档/图片走 Claude API，使用你自己的凭据。

---

## 二、安装与配置

### 前置条件

- Python 3.10+
- Claude Code CLI 已配置

### 安装

```bash
pip install graphifyy
graphify install          # 在 Claude Code 中注册 /graphify 技能
```

> **本项目已完成安装**：`graphifyy` 已通过 pipx 全局安装，`/graphify` 技能已在 `~/.claude/CLAUDE.md` 中注册，直接使用即可。

### 验证

```bash
which graphify            # → ~/.local/bin/graphify（或 pipx 路径）
python3 -c "import graphify; print('OK')"
```

### 忽略文件

项目根目录已配置 `.graphifyignore`（语法同 `.gitignore`），以下默认忽略：

- `node_modules/`、`dist/`、`build/` 等构建产物
- `.env`、`*.key` 等密钥文件
- `graphify-out/`（避免自引用）

---

## 三、使用场景

### 场景 1：新人接手项目——3 分钟建立全局认知

**痛点**：接手陌生项目，文档散落各处，不知道哪些文件最重要、模块如何关联。

```
/graphify .
```

Graphify 自动识别 God 节点（被最多文件引用的核心概念）和社区（功能模块聚类），在 `graph.html` 中展示全貌。

**预期收获**：
- 哪几份文档是"神经中枢"（God Nodes）
- 哪些模块在架构上强耦合
- 可以直接问："认证流程和数据库 Schema 是如何关联的？"

---

### 场景 2：架构评审——找到隐藏依赖

**痛点**：准备架构评审，需要梳理各服务间的依赖链，手动整理费时且容易遗漏。

```
/graphify docs/03_architecture --mode deep
```

`--mode deep` 开启激进推断模式，识别间接依赖（共享数据结构、隐含假设）并标注为 `INFERRED`。

---

### 场景 3：PRD 发布后同步知识图谱

**痛点**：新 PRD 发布，需要理解它与现有系统文档的关联，确认影响范围。

```bash
# 先把新 PRD 加入图谱
/graphify add https://... --author "产品负责人姓名"

# 或直接重新提取更新
/graphify . --update
```

`--update` 只重新提取有变化的文件（SHA256 缓存），节省 token。

---

### 场景 4：代码库知识查询（替代全文搜索）

**痛点**：想知道某个概念在哪里被使用，全文搜索返回太多噪音。

```
/graphify query "认证流程是如何触发数据库写入的？"
/graphify path "UserAuth" "DBSchema"
/graphify explain "MediFlow"
```

图谱查询基于图结构 BFS/DFS 遍历，比全文搜索更精准，且结果包含置信度标注。

---

### 场景 5：API 文档对齐设计系统

**痛点**：API 规范和设计系统文档单独维护，不确定是否存在命名冲突或语义漂移。

```
/graphify docs/03_architecture docs/02_design
```

跨目录建图，`semantically_similar_to` 边会暴露不同文档中描述同一概念的节点。

---

### 场景 6：持续监控——Watch 模式

**痛点**：团队在快速迭代，文档频繁变更，希望图谱自动更新。

```bash
# 后台启动监控（代码变更时无 LLM、秒级重建）
/graphify . --watch
```

- 代码文件变更 → 纯 AST 重建，无 API 调用
- 文档/图片变更 → 提示运行 `/graphify --update`

---

## 四、命令速查手册

### 全量建图

| 命令 | 说明 |
|------|------|
| `/graphify .` | 对当前目录建图（默认）|
| `/graphify <路径>` | 指定目录建图 |
| `/graphify <路径> --mode deep` | 激进推断模式，提取更多 INFERRED 边 |
| `/graphify <路径> --no-viz` | 跳过 HTML 可视化，只生成报告 + JSON |
| `/graphify <路径> --svg` | 额外导出 SVG（可嵌入 Notion/GitHub）|
| `/graphify <路径> --graphml` | 导出 GraphML（Gephi、yEd 打开）|

### 增量更新

| 命令 | 说明 |
|------|------|
| `/graphify <路径> --update` | 只重新提取新增/变更文件（SHA256 缓存）|
| `/graphify <路径> --cluster-only` | 仅重新聚类，不重新提取 |

### 查询与探索

| 命令 | 说明 |
|------|------|
| `/graphify query "<问题>"` | BFS 遍历，宽泛上下文 |
| `/graphify query "<问题>" --dfs` | DFS 遍历，追踪特定路径 |
| `/graphify query "<问题>" --budget 1500` | 限制返回 token 数 |
| `/graphify path "节点A" "节点B"` | 查找两概念之间的最短路径 |
| `/graphify explain "<概念>"` | 平白语言解释某节点及其所有连接 |

### 内容摄取

| 命令 | 说明 |
|------|------|
| `/graphify add <URL>` | 抓取 URL（arXiv/Twitter/网页/PDF）加入图谱 |
| `/graphify add <URL> --author "姓名"` | 标注原作者 |
| `/graphify add <URL> --contributor "姓名"` | 标注添加者 |

### 高级导出

| 命令 | 说明 |
|------|------|
| `/graphify <路径> --neo4j` | 生成 Cypher 文件（Neo4j 导入）|
| `/graphify <路径> --neo4j-push bolt://localhost:7687` | 直接推送到 Neo4j |
| `/graphify <路径> --mcp` | 启动 MCP stdio 服务，供其他 Agent 查询图谱 |

---

## 五、与本项目工作流集成

### 推荐场景触发时机

| 时机 | 命令 | 说明 |
|------|------|------|
| 新人 Onboarding | `/graphify .` | 快速建立全局认知 |
| PRD 更新后 | `/graphify docs/01_product --update` | 同步产品知识图谱 |
| 架构设计前 | `/graphify docs/03_architecture --mode deep` | 梳理现有依赖 |
| Sprint 复盘后 | `/graphify . --update` | 更新全量图谱 |
| 接手遗留代码 | `/graphify <代码目录>` | 理解历史决策 |

### 与 Memory 系统联动

graphify 生成的 `GRAPH_REPORT.md` 可作为项目架构认知的参考：

```
/graphify .                           # 建图
# 查看 graphify-out/GRAPH_REPORT.md
# 将核心发现记录到 memory/project-facts.md
```

### Git Hook 自动重建（可选）

```bash
graphify hook install    # 每次 git commit 后自动重建代码图谱
graphify hook status     # 检查 hook 状态
graphify hook uninstall  # 卸载
```

---

## 六、输出产物说明

### `graphify-out/GRAPH_REPORT.md` 结构

```
## God Nodes（高度中心节点）
列出 degree 最高的节点——这些是架构核心概念

## Surprising Connections（惊喜连接）
跨社区的意外关联——最容易被忽略的隐藏依赖

## Suggested Questions（建议提问）
图结构能直接回答的、有价值的问题
```

### 边的置信度标注

| 标注 | 含义 |
|------|------|
| `EXTRACTED` | 源文件中明确存在的关系（confidence_score = 1.0）|
| `INFERRED` | 合理推断（0.4–0.9，具体值反映推断强度）|
| `AMBIGUOUS` | 不确定，需人工复核（0.1–0.3）|

---

## 七、常见问题

**Q: 建图时 token 消耗大吗？**
代码文件走本地 AST，不消耗 token。只有 `.md`、`.pdf`、图片等文档类文件会调用 Claude API。首次建图后有 SHA256 缓存，`--update` 模式只处理变更文件。

**Q: 可以只对部分目录建图吗？**
可以。`/graphify docs/03_architecture` 只对架构文档建图；`/graphify src/` 只对代码建图。多个路径分别建图后，用 `--update` 合并。

**Q: `graph.html` 节点太多看不清怎么办？**
打开 `graph.html` 后，使用左侧的社区过滤器，逐个社区探索。也可以用 `/graphify explain <概念>` 聚焦单个节点。

**Q: 图谱跨会话还能查询吗？**
能。`graphify-out/graph.json` 是持久化存储，后续会话直接运行 `/graphify query` 即可，无需重新建图。

---

## 八、相关资源

- GitHub 项目：[github.com/safishamsi/graphify](https://github.com/safishamsi/graphify)
- 安装包：`pip install graphifyy`（注意：包名有两个 y）
- 本项目技能索引：[SKILLS_INDEX.md](../06_handbooks/ai-native/SKILLS_INDEX.md)
- 相关工具：[autoresearch-guide.md](autoresearch-guide.md)（自动研究）、[routing-matrix.md](routing-matrix.md)（模型路由）

---

*最后更新: 2026-04-07 by Claude Code*
