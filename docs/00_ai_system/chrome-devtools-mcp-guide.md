# Chrome DevTools MCP 接入指南

> 让 AI 编码助手直接控制本机 Chrome，复用已登录态，读取页面数据、DOM、网络请求。

## 原理

`chrome-devtools-mcp` 是 Google 官方的 MCP Server，通过 Chrome 远程调试协议（CDP）连接本机 Chrome。
AI 编码助手（Claude Code / Cursor / Gemini CLI 等）通过 MCP 工具调用即可操作浏览器。

**推荐方案：`--autoConnect` 模式（Chrome 144+）**

- 直接连接当前正在使用的 Chrome 实例
- **完整保留登录态**，无需重新登录
- 无需手动启动带调试参数的 Chrome
- 需要在 Chrome 中一次性开启远程调试

> 官方文档：[developer.chrome.com/blog/chrome-devtools-mcp](https://developer.chrome.com/blog/chrome-devtools-mcp)
> GitHub：[ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp)

---

## 环境要求

| 依赖 | 最低版本 |
|------|---------|
| Node.js | v20.19+（推荐 LTS） |
| Chrome | 144+（Stable） |
| npm / npx | 随 Node 自带 |

---

## 一次性配置

### 1. Chrome 端：开启远程调试

1. 打开 Chrome 地址栏，访问 `chrome://inspect/#remote-debugging`
2. **开启** Remote debugging 开关
3. 看到 `Server running at: ws://...` 即为成功（不是 "starting…"）

> [!IMPORTANT]
> 如果卡在 "Server running at: starting…"，大概率是有**残留的 MCP 进程**占用了调试端口。执行以下命令清理后重试：
> ```bash
> pkill -f "chrome-devtools-mcp"
> ```
> 然后**关闭并重新打开 Chrome**，重新访问上述地址。

### 2. 项目配置 `.mcp.json`

项目根目录 `.mcp.json`（已配置）：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "chrome-devtools-mcp@latest",
        "--autoConnect"
      ]
    }
  }
}
```

> `--autoConnect`：自动发现并连接本机正在运行的 Chrome 实例（Chrome 144+），复用当前 Profile 的所有登录态。

### 3. 全局配置（可选）

如果希望所有项目都可以使用 chrome-devtools MCP，将相同内容写入 `~/.mcp.json`。

---

## 使用流程

```
1. 确保 Chrome 已打开并正常使用（已登录目标网站）
2. 确认 chrome://inspect/#remote-debugging 的开关已开启
3. 在 AI 编码助手中直接描述任务，MCP 工具自动调用
```

> [!NOTE]
> 首次连接时，Chrome 会弹出授权弹窗请求允许远程调试连接，**点击允许**即可。
> 连接成功后浏览器顶部会显示 "Chrome is being controlled by automated test software" 横幅。

### 验证 MCP 可用

在 AI 编码助手中输入：

```
请检查 web.dev 的 LCP 性能
```

如果 MCP 正常工作，助手会自动打开浏览器、记录性能轨迹并分析结果。

---

## 常见问题

### Q: `chrome://inspect/#remote-debugging` 一直显示 "starting…"

**原因**：有残留的 `chrome-devtools-mcp` 进程占用了调试端口。

**修复**：

```bash
# 终止所有残留进程
pkill -f "chrome-devtools-mcp"
# 确认端口释放
lsof -i :9222 || echo "端口已释放"
# 关闭并重新打开 Chrome
```

### Q: `--autoConnect` 超时，连接不上浏览器

**原因**：Chrome 远程调试未正确启用，或有其他工具占用调试端口。

**排查顺序**：

1. 确认 Chrome 版本 ≥ 144（地址栏输入 `chrome://version`）
2. 确认 `chrome://inspect/#remote-debugging` 开关已开启
3. 确认授权弹窗已点击允许
4. 终止其他可能占用端口的工具

### Q: 需要连接到带特定参数的 Chrome（备用方案）

如果 `--autoConnect` 不适用（如需要连接远程 Chrome），可以退回手动模式：

```bash
# 启动带调试端口的 Chrome（会使用独立 Profile）
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=9222 \
  --remote-allow-origins="*" \
  --user-data-dir="$HOME/.chrome-debug-profile" \
  --no-first-run
```

对应 `.mcp.json` 配置改为：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "chrome-devtools-mcp@latest",
        "--browserUrl",
        "http://127.0.0.1:9222"
      ]
    }
  }
}
```

> [!WARNING]
> 手动模式使用独立 Profile，**不保留登录态**，每次需重新登录。如需保留 session，请固定 `--user-data-dir` 路径。

### Q: macOS 权限问题导致连接失败

**原因**：MCP 客户端缺少系统权限。

**修复**：前往 **系统设置 > 隐私与安全性 > 蓝牙/自动化**，确保你的编辑器/终端有相应权限。

### Q: `curl localhost:9222` 返回 503

**原因**：系统 HTTP 代理（如 Clash/xray）拦截了 localhost 请求。

**修复**：

```bash
curl --noproxy "*" http://localhost:9222/json
```

---

## 调试技巧

启用详细日志排查问题：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "chrome-devtools-mcp@latest",
        "--autoConnect",
        "--log-file",
        "/tmp/chrome-mcp.log"
      ],
      "env": {
        "DEBUG": "*"
      }
    }
  }
}
```

查看日志：`cat /tmp/chrome-mcp.log`

---

## 可用 MCP 工具速查

### 输入自动化（9 工具）

| 工具 | 用途 |
|------|------|
| `click` | 点击元素 |
| `fill` | 填充输入框 |
| `fill_form` | 批量填写表单 |
| `hover` | 悬停元素 |
| `press_key` | 模拟按键 |
| `type_text` | 键盘输入文本 |
| `drag` | 拖拽元素 |
| `handle_dialog` | 处理弹窗对话框 |
| `upload_file` | 上传文件 |

### 页面导航（6 工具）

| 工具 | 用途 |
|------|------|
| `list_pages` | 列出所有打开的标签页 |
| `select_page` | 切换到指定标签页 |
| `navigate_page` | 跳转 URL |
| `new_page` | 新建标签页 |
| `close_page` | 关闭标签页 |
| `wait_for` | 等待元素或条件出现 |

### 调试 & 分析（6 工具）

| 工具 | 用途 |
|------|------|
| `take_screenshot` | 截图当前页面 |
| `take_snapshot` | 获取 DOM 快照 |
| `evaluate_script` | 在页面执行 JS，返回结果 |
| `list_console_messages` | 列出控制台消息 |
| `get_console_message` | 获取单条控制台消息详情 |
| `lighthouse_audit` | 运行 Lighthouse 审计 |

### 网络（2 工具）

| 工具 | 用途 |
|------|------|
| `list_network_requests` | 列出页面网络请求 |
| `get_network_request` | 获取单个请求的详情/响应体 |

### 性能（4 工具）

| 工具 | 用途 |
|------|------|
| `performance_start_trace` | 开始性能追踪 |
| `performance_stop_trace` | 停止性能追踪 |
| `performance_analyze_insight` | 分析性能洞察 |
| `take_memory_snapshot` | 内存快照 |

### 模拟（2 工具）

| 工具 | 用途 |
|------|------|
| `emulate` | 模拟设备（如 iPhone、iPad） |
| `resize_page` | 调整视口大小 |
