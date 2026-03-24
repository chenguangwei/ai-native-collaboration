# Switch Role（切换角色）

切换当前 AI 工作角色，加载对应角色的记忆和工作焦点。

## 使用方法

```
/switch-role <role>
```

支持的角色：`fullstack` | `frontend` | `backend` | `pm` | `qa` | `devops` | `architect`

## 执行流程

1. **保存当前角色状态**

   将当前未完成任务追加到 `memory/roles/{current-role}/today.md`。

2. **更新 project-config.json**

   ```bash
   python3 -c "
   import json, sys
   role = sys.argv[1]
   with open('.claude/project-config.json', 'r+') as f:
       cfg = json.load(f)
       cfg['currentRole'] = role
       f.seek(0)
       json.dump(cfg, f, indent=2, ensure_ascii=False)
       f.write('\n')
       f.truncate()
   print('角色已切换为:', role)
   " "$ARGS"
   ```

3. **加载新角色上下文**

   - 读取 `memory/roles/{new-role}/today.md`（新角色今日日志）
   - 读取 `.claude/project-config.json` 中新角色的 `focus` 目录
   - 输出切换确认：

   ```
   🎭 角色切换完成

   当前角色: {new-role}
   工作焦点: {focus directories}
   今日日志: {summary from today.md or "暂无记录"}

   准备开始 {new-role} 视角的工作。
   ```

## 注意

- 切换角色不会清除其他角色的记忆，只改变当前 AI 的工作视角
- 多 AI 并发时，每个窗口应保持固定角色，避免频繁切换
- 使用 `scripts/lock.sh status` 检查当前是否有任务锁持有中
