# SegmentTree - Efficient Range Operations Data Structure

[English](https://github.com/0Ayachi0/SegmentTree/blob/main/README.md) | [简体中文](https://github.com/0Ayachi0/SegmentTree/blob/main/README_zh_CN.md)

Segment Tree is a tree data structure that supports efficient range query and range update operations. This library provides a flexible and efficient implementation of Segment Tree in MoonBit language.

## 🚀 Features

- ✨ Support for range query operations (sum, max, min, etc.)
- 📊 Support for point update operations
- 🔀 Support for range update operations (with lazy propagation)
- 📦 Generic implementation to handle various data types
- 📚 Flexible merge and update operations

## 📥 Installation & Dependencies

This project uses MoonBit's package management system.

### 🛠️ Developer Guide

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/SegmentTree.git
   cd SegmentTree
   ```

2. **Build the project**
   ```bash
   moon build
   ```

3. **Run tests**
   ```bash
   moon test
   ```

## 🚀 Usage

### 🔨 Creating a Segment Tree

```moonbit
// Create a range sum segment tree
let sum_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // Original array
  fn(a, b) { a + b },                // Merge operation: sum
  fn(a, b) { a + b },                // Update operation: add value
  0                                  // Default value: 0
)

// Create a range maximum segment tree
let max_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // Original array
  fn(a, b) { if a > b { a } else { b } },  // Merge operation: maximum
  fn(a, b) { a + b },                      // Update operation: add value
  -9999999                                 // Default value: a very small number
)

// Create a range minimum segment tree
let min_tree = @SegmentTree.new(
  [1, 3, 5, 7, 9],                   // Original array
  fn(a, b) { if a < b { a } else { b } },  // Merge operation: minimum
  fn(a, b) { a + b },                      // Update operation: add value
  9999999                                  // Default value: a very large number
)
```

### ⚙️ Basic Operations

```moonbit
// Query the value in range [l, r]
let result = segment_tree.query(l, r)

// Update the value at position pos
segment_tree.update_point(pos, value)

// Update values in range [l, r]
segment_tree.update_range(l, r, value)
```

## ⏱️ Time Complexity

| Operation | Time Complexity | Description |
|-----------|-----------------|-------------|
| Create segment tree | O(n) | Initialize the segment tree, where n is the array length |
| Query operation | O(log n) | Query a range value |
| Point update | O(log n) | Update a single element |
| Range update | O(log n) | Update all elements in a range |

## 📁 Project Structure

```
SegmentTree/
├── src/                # Source code directory
│   ├── SegmentTree.mbt    # Segment tree implementation
│   └── SegmentTree.mbti   # Interface definition
├── tests/              # Test files
└── README.md           # Project documentation
```

## 👥 Contribution Guidelines

Contributions to the SegmentTree library are welcome! Here's how to contribute:

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request 