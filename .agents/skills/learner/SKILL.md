---
name: learner
version: 1.0.0
description: |
  从当前会话中提取可复用的项目级调试知识，保存为 skill 文件。
  解决了难题、发现了隐藏 gotcha、找到了非文档化的特定行为后使用。
  触发词：保存这个解法、提取经验、记住这个方法
allowed-tools:
  - Read
  - Write
  - AskUserQuestion
---

# /learner

从当前会话提取项目专属的调试知识，保存供未来使用。

## 核心原则

可复用的 skill 不是代码片段，而是**决策启发式规则**——教会 AI 如何思考一类问题。

**区别**：
- 坏的（模仿）："看到 NullPointerException 时加这个 try-catch"
- 好的（可复用）："这个项目的 Spring Bean 懒加载模式导致在特定请求路径下 @Autowired 对象为 null。原则：在 Controller 层测试时必须显式初始化上下文。"

## 质量门禁

提取前，以下三条必须全部为 YES：
- [ ] 这个问题无法在 5 分钟内 Google 到答案？
- [ ] 这个知识特定于当前项目（有具体文件路径/行号/错误信息）？
- [ ] 这花费了真实的调试时间？

## 不适合提取的内容（直接拒绝）

- 通用编程模式（用文档代替）
- 重构技巧（通用的）
- 库的使用示例（用官方文档）
- 任何初级工程师 5 分钟能 Google 到的

## 执行步骤

### Step 1: 收集信息

通过 AskUserQuestion 确认以下信息（如果会话上下文已有则跳过）：

**问题描述**：发生了什么具体错误或困惑？
- 包含：实际错误信息、文件路径、行号
- 示例："src/service/UserService.java:89 的 NullPointerException，只在并发请求时出现"

**解决方案**：具体的修复方式（不是泛泛建议）
- 包含：代码片段、配置修改、文件路径

**触发词**：未来遇到此问题时会出现的关键词
- 示例：["NullPointerException", "UserService", "并发请求", "懒加载"]

### Step 2: 质量验证

评估以下标准，任一不满足则拒绝提取，告知用户为什么：
- **不可 Google**：是否有具体的项目上下文？
- **有文件锚点**：是否包含具体文件路径或错误信息？
- **可操作**：解决方案是否精确到能直接使用？
- **有代价**：是否花费了真实调试时间？

### Step 3: 分类

判断是：
- **Expertise（领域知识）**：模式、陷阱、非文档行为 → 保存为 `{topic}-expertise.md`
- **Workflow（操作流程）**：步骤序列、操作规范 → 保存为 `{topic}-workflow.md`

### Step 4: 保存

**格式**：
```markdown
---
name: {skill 名称}
type: expertise | workflow
triggers: [关键词1, 关键词2, ...]
project: {项目名}
extracted: {日期}
---

# {Skill 名称}

## 洞察
发现的核心**原则**是什么？不是代码，而是心智模型。

## 为什么重要
不知道这个会出什么问题？什么症状让你来到这里？

## 识别模式
什么情况下这个 skill 适用？有哪些信号？

## 方法
决策启发式规则，不只是代码。Claude 应该如何**思考**这个问题？

## 示例（可选）
如果代码有帮助，展示它——但作为原则的说明，而不是复制粘贴材料。
```

**保存路径**：`.agents/skills/learned/{topic}-{type}.md`

同时在 `.claude/skills/` 创建符号链接：
```bash
ln -s ../../.agents/skills/learned/{topic}-{type} .claude/skills/{topic}-{type}
```

告知用户：
```
已提取并保存 skill：.agents/skills/learned/{filename}

触发词：{triggers}
未来遇到 {触发词示例} 时，这个知识会自动加入上下文。

建议提交：git add .agents/skills/learned/ .claude/skills/ && git commit -m "feat(skills): 提取 {topic} 调试经验"
```
