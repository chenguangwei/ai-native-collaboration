# 📋 人员目录

> 按 Git 用户名组织的个人工作日志

## 说明

此目录按 `git config user.email` 的值自动创建子目录。

## 常用命令

```bash
# 查看当前 Git 用户
git config user.email

# 查看自己的今日工作
PERSON_DIR=$(git config user.email | tr '@' '_')
cat memory/persons/$PERSON_DIR/today.md

# 创建自己的目录
PERSON_DIR=$(git config user.email | tr '@' '_')
mkdir -p memory/persons/$PERSON_DIR
```

## 目录命名规则

| Git Email | 目录名 |
|-----------|--------|
| alice@company.com | alice_company.com |
| bob@github.com | bob_github.com |

> 注：@ 符号被替换为下划线
