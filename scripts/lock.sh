#!/bin/bash
# AI 任务锁工具
# 用法：
#   ./scripts/lock.sh acquire <task-id> <role>   加锁
#   ./scripts/lock.sh release <task-id>           释放
#   ./scripts/lock.sh status                      查看所有锁
#   ./scripts/lock.sh clean                       清理过期锁（>30分钟）

set -e

LOCK_DIR="memory/lock"
EXPIRE_SECONDS=1800  # 30 分钟

mkdir -p "$LOCK_DIR"

cmd="${1:-status}"
task_id="$2"
role="$3"

acquire() {
  local lock_file="$LOCK_DIR/$task_id.lock"
  if [ -f "$lock_file" ]; then
    local role_held ts now age
    IFS=: read -r role_held _ ts < "$lock_file"
    now=$(date -u +%s)
    age=$((now - ts))
    if [ $age -lt $EXPIRE_SECONDS ]; then
      echo "❌ 任务 [$task_id] 已被 [$role_held] 持有（${age}s 前加锁）"
      exit 1
    else
      echo "⚠️  发现过期锁，自动清理..."
      rm -f "$lock_file"
    fi
  fi
  echo "$role:$$:$(date -u +%s)" > "$lock_file"
  echo "✅ [$role] 已锁定任务 [$task_id]"
}

release() {
  local lock_file="$LOCK_DIR/$task_id.lock"
  if [ ! -f "$lock_file" ]; then
    echo "⚠️  任务 [$task_id] 没有锁"
    exit 0
  fi
  rm -f "$lock_file"
  echo "🔓 任务 [$task_id] 已释放"
}

status() {
  local found=0
  for f in "$LOCK_DIR"/*.lock; do
    [ -f "$f" ] || continue
    found=1
    break
  done
  if [ $found -eq 0 ]; then
    echo "✅ 当前无任务锁"
    return
  fi
  echo "📋 当前任务锁："
  for f in "$LOCK_DIR"/*.lock; do
    [ -f "$f" ] || continue
    local task role pid ts now age
    task=$(basename "$f" .lock)
    IFS=: read -r role pid ts < "$f"
    now=$(date -u +%s)
    age=$((now - ts))
    echo "  [$task] 持有者: $role，已持续: ${age}s"
  done
}

clean() {
  local cleaned=0
  for f in "$LOCK_DIR"/*.lock; do
    [ -f "$f" ] || continue
    local ts now age
    IFS=: read -r _ _ ts < "$f"
    now=$(date -u +%s)
    age=$((now - ts))
    if [ $age -ge $EXPIRE_SECONDS ]; then
      echo "🗑️  清理过期锁: $(basename $f .lock)（${age}s）"
      rm -f "$f"
      cleaned=$((cleaned + 1))
    fi
  done
  echo "清理完成，共清理 $cleaned 个过期锁"
}

case "$cmd" in
  acquire) acquire ;;
  release) release ;;
  status)  status  ;;
  clean)   clean   ;;
  *) echo "用法: lock.sh <acquire|release|status|clean> [task-id] [role]"; exit 1 ;;
esac
