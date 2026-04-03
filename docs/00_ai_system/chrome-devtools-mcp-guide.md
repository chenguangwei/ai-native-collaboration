# Chrome DevTools MCP 接入指南

> 让 Claude Code 直接控制本机 Chrome，读取已登录页面的数据、DOM、网络请求。

## 原理

`chrome-devtools-mcp` 通过 Chrome 远程调试协议（CDP）连接本机 Chrome，Claude Code 通过 MCP 工具调用即可操作浏览器。关键约束：**Chrome 必须在启动时就带上 `--remote-debugging-port` 参数**，运行中的 Chrome 无法动态开启。

---

## 一次性配置

### 1. 写入 `.mcp.json`

项目根目录 `.mcp.json`（已配置，仅供参考）：

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "chrome-devtools-mcp@latest",
        "--port",
        "9222"
      ],
      "env": {}
    }
  }
}
```

> `--port 9222`：直连指定端口，不依赖 `DevToolsActivePort` 文件（`--autoConnect` 在非默认 Profile 下会失效）。

### 2. 添加 `debugchrome` 快捷命令

```bash
# 写入 ~/.zshrc
alias debugchrome='"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=9222 \
  --remote-allow-origins="*" \
  --user-data-dir=/tmp/chrome-debug \
  --no-first-run'

source ~/.zshrc
```

参数说明：

| 参数 | 作用 |
|------|------|
| `--remote-debugging-port=9222` | 开启 CDP 调试端口 |
| `--remote-allow-origins="*"` | Chrome 146+ 必须加，否则绑定端口但拒绝连接 |
| `--user-data-dir=/tmp/chrome-debug` | 独立临时 Profile，避免 SingletonLock 冲突 |
| `--no-first-run` | 跳过首次启动向导 |

---

## 每次使用流程

```
1. 完全退出 Chrome（Cmd+Q 或 pkill -x "Google Chrome"）
2. 终端执行 debugchrome
3. 在 Chrome 中登录目标网站
4. 重启 Claude Code 会话（让 MCP 生效）
5. 在 Claude Code 中直接描述任务，MCP 工具自动调用
```

### 验证端口已开启

```bash
curl --noproxy "*" http://localhost:9222/json/version
```

返回 JSON（含 `Browser`、`webSocketDebuggerUrl` 字段）即为成功。

---

## 常见问题

### Q: Chrome 带了参数启动，但端口没有监听

**原因**：系统已有一个没带调试参数的 Chrome 在运行。macOS 检测到同一应用已启动，会把新参数忽略，直接唤醒旧进程。

**修复**：彻底退出旧 Chrome 再启动。

```bash
pkill -x "Google Chrome" && sleep 2 && debugchrome
```

### Q: `curl localhost:9222` 返回 503

**原因**：系统设置了 HTTP 代理（如 Clash/xray），`localhost` 请求被代理拦截。

**修复**：加 `--noproxy "*"` 绕过代理：

```bash
curl --noproxy "*" http://localhost:9222/json
```

### Q: MCP 报 `Could not find DevToolsActivePort`

**原因**：`.mcp.json` 使用了 `--autoConnect`，该模式依赖默认 Chrome Profile 下的 `DevToolsActivePort` 文件，临时 Profile 不会生成此文件。

**修复**：`.mcp.json` 改为 `--port 9222` 直连（见上方配置）。

### Q: `/tmp/chrome-debug` 没有登录 session

这是预期行为。临时 Profile 是全新状态，每次使用前需在 Chrome 中重新登录目标网站。如需保留 session，可改为固定目录：

```bash
--user-data-dir="$HOME/.chrome-debug-profile"
```

---

## 可用 MCP 工具速查

| 工具 | 用途 |
|------|------|
| `list_pages` | 列出所有打开的标签页 |
| `select_page` | 切换到指定标签页 |
| `navigate_page` | 跳转 URL |
| `take_screenshot` | 截图当前页面 |
| `evaluate_script` | 在页面执行 JS，返回 JSON |
| `list_network_requests` | 列出页面网络请求（XHR/Fetch） |
| `get_network_request` | 获取单个请求的详情/响应体 |
| `click` / `fill` / `press_key` | 模拟用户交互 |
| `wait_for` | 等待元素或条件出现 |
