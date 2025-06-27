# 线段树 - 高效区间操作数据结构

[English](https://github.com/0Ayachi0/SegmentTree/blob/main/README.md) | [简体中文](https://github.com/0Ayachi0/SegmentTree/blob/main/README_zh_CN.md)

线段树是一种支持高效区间查询和区间修改操作的树形数据结构。这个库提供了一个灵活、高效的线段树实现，适用于MoonBit语言。

## 🚀 特性

- ✨ 支持区间查询操作（如区间求和、区间最大值、区间最小值等）
- 📊 支持单点修改操作
- 🔀 支持区间修改操作（使用懒惰传播优化）
- 📦 泛型实现，可以处理各种数据类型
- 📚 灵活的合并和更新操作

## 📥 安装与依赖

本项目使用MoonBit的包管理系统来管理依赖。

### 🛠️ 开发者使用指南

1. **克隆项目**
   ```bash
   git clone https://github.com/your-username/SegmentTree.git
   cd SegmentTree
   ```

2. **构建项目**
   ```bash
   moon build
   ```

3. **运行测试**
   ```bash
   moon test
   ```

## 🚀 使用方法

### 🔨 创建线段树

```moonbit
// 创建一个区间求和线段树
let sum_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // 原始数组
  fn(a, b) { a + b },                // 合并操作：求和
  fn(a, b) { a + b },                // 更新操作：增加值
  0                                  // 默认值：0
)

// 创建一个区间最大值线段树
let max_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // 原始数组
  fn(a, b) { if a > b { a } else { b } },  // 合并操作：取最大值
  fn(a, b) { a + b },                      // 更新操作：增加值
  -9999999                                 // 默认值：一个很小的数
)

// 创建一个区间最小值线段树
let min_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // 原始数组
  fn(a, b) { if a < b { a } else { b } },  // 合并操作：取最小值
  fn(a, b) { a + b },                      // 更新操作：增加值
  9999999                                  // 默认值：一个很大的数
)
```

### ⚙️ 基本操作

```moonbit
// 查询区间[l, r]的值
let result = segment_tree.query(l, r)

// 更新位置pos的值
segment_tree.update_point(pos, value)

// 更新区间[l, r]的值
segment_tree.update_range(l, r, value)
```

## ⏱️ 时间复杂度

| 操作 | 时间复杂度 | 描述 |
|-----|-----------|-----|
| 创建线段树 | O(n) | 初始化线段树，n为数组长度 |
| 查询操作 | O(log n) | 查询区间值 |
| 单点更新 | O(log n) | 更新单个元素 |
| 区间更新 | O(log n) | 更新区间内所有元素 |

## 📁 项目结构

```
SegmentTree/
├── src/                # 源代码目录
│   ├── SegmentTree.mbt    # 线段树实现
│   └── SegmentTree.mbti   # 接口定义
├── tests/              # 测试文件
└── README.md           # 项目文档
```

## 👥 贡献指南

欢迎对线段树库进行贡献！以下是参与贡献的步骤：

1. Fork本仓库
2. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 开启一个Pull Request 