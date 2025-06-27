// SegmentTree - 线段树实现
// 提供高效的区间查询和修改操作

/// 定义线段树中节点存储的信息
pub struct Node[T] {
  /// 节点值（根据操作不同，可能是区间和、最大值、最小值等）
  mut value : T
  /// 懒惰标记，用于延迟更新
  mut lazy : T?
} derive(Show)

/// 线段树主结构
pub struct SegmentTree[T] {
  /// 存储线段树节点的数组
  nodes : Array[Node[T]]
  /// 原始数据数组
  data : Array[T]
  /// 数组长度
  n : Int
  /// 合并操作函数（如求和、求最大值、求最小值等）
  merge : (T, T) -> T
  /// 更新操作函数（如增加、赋值等）
  update : (T, T) -> T
  /// 默认值（如求和为0，求最大值为负无穷等）
  default : T
} derive(Show)

///|
/// 创建新的线段树
/// 
/// 参数:
/// * `data` : 原始数据数组
/// * `merge` : 合并操作函数
/// * `update` : 更新操作函数
/// * `default` : 默认值
/// 
/// 返回一个新的线段树
pub fn new[T](
  data : Array[T],
  merge : (T, T) -> T,
  update : (T, T) -> T,
  default : T
) -> SegmentTree[T] {
  let n = data.length()
  // 计算需要的节点数量，4*n是一个安全的上界
  let size = 4 * n
  
  // 初始化节点数组
  let nodes = []
  for _ in 0..<size {
    nodes.push(Node::{ value: default, lazy: None })
  }
  
  let st = SegmentTree::{
    nodes,
    data,
    n,
    merge,
    update,
    default
  }
  
  // 构建线段树
  st.build(0, 0, n - 1)
  st
}

///|
/// 构建线段树
/// 
/// 参数:
/// * `self` : 线段树
/// * `node` : 当前节点的索引
/// * `start` : 当前区间的起始位置
/// * `end` : 当前区间的结束位置
fn build[T](self : SegmentTree[T], node : Int, start : Int, end : Int) -> Unit {
  if start == end {
    // 叶子节点，直接赋值
    self.nodes[node].value = self.data[start]
  } else {
    // 非叶子节点，递归构建左右子树
    let mid = (start + end) / 2
    let left_child = 2 * node + 1
    let right_child = 2 * node + 2
    
    self.build(left_child, start, mid)
    self.build(right_child, mid + 1, end)
    
    // 合并左右子节点的值
    self.nodes[node].value = (self.merge)(
      self.nodes[left_child].value,
      self.nodes[right_child].value
    )
  }
}

///|
/// 传递懒惰标记到子节点
/// 
/// 参数:
/// * `self` : 线段树
/// * `node` : 当前节点的索引
/// * `start` : 当前区间的起始位置
/// * `end` : 当前区间的结束位置
fn push_down[T](self : SegmentTree[T], node : Int, start : Int, end : Int) -> Unit {
  if start != end {
    let left_child = 2 * node + 1
    let right_child = 2 * node + 2
    
    match self.nodes[node].lazy {
      Some(lazy_val) => {
        // 更新左子节点
        match self.nodes[left_child].lazy {
          Some(left_lazy) => {
            self.nodes[left_child].lazy = Some((self.update)(left_lazy, lazy_val))
          }
          None => {
            self.nodes[left_child].lazy = Some(lazy_val)
          }
        }
        self.nodes[left_child].value = (self.update)(self.nodes[left_child].value, lazy_val)
        
        // 更新右子节点
        match self.nodes[right_child].lazy {
          Some(right_lazy) => {
            self.nodes[right_child].lazy = Some((self.update)(right_lazy, lazy_val))
          }
          None => {
            self.nodes[right_child].lazy = Some(lazy_val)
          }
        }
        self.nodes[right_child].value = (self.update)(self.nodes[right_child].value, lazy_val)
        
        // 清除当前节点的懒惰标记
        self.nodes[node].lazy = None
      }
      None => ignore(None)
    }
  }
}

///|
/// 查询区间值
/// 
/// 参数:
/// * `self` : 线段树
/// * `l` : 查询区间起始位置
/// * `r` : 查询区间结束位置
/// 
/// 返回区间[l, r]的查询结果
pub fn query[T](self : SegmentTree[T], l : Int, r : Int) -> T {
  self.query_internal(0, 0, self.n - 1, l, r)
}

///|
/// 内部查询函数
/// 
/// 参数:
/// * `self` : 线段树
/// * `node` : 当前节点的索引
/// * `start` : 当前节点表示的区间起始位置
/// * `end` : 当前节点表示的区间结束位置
/// * `l` : 查询区间起始位置
/// * `r` : 查询区间结束位置
fn query_internal[T](
  self : SegmentTree[T], 
  node : Int, 
  start : Int, 
  end : Int, 
  l : Int, 
  r : Int
) -> T {
  // 如果查询区间在当前区间之外
  if r < start || end < l {
    return self.default
  }
  
  // 如果查询区间完全包含当前区间
  if l <= start && end <= r {
    return self.nodes[node].value
  }
  
  // 传递懒惰标记
  self.push_down(node, start, end)
  
  // 分割当前区间
  let mid = (start + end) / 2
  let left_child = 2 * node + 1
  let right_child = 2 * node + 2
  
  // 合并左右子树的查询结果
  let left_result = self.query_internal(left_child, start, mid, l, r)
  let right_result = self.query_internal(right_child, mid + 1, end, l, r)
  
  (self.merge)(left_result, right_result)
}

///|
/// 更新单个元素值
/// 
/// 参数:
/// * `self` : 线段树
/// * `pos` : 要更新的位置
/// * `value` : 新值
pub fn update_point[T](self : SegmentTree[T], pos : Int, value : T) -> Unit {
  self.update_internal(0, 0, self.n - 1, pos, pos, value)
}

///|
/// 更新区间值
/// 
/// 参数:
/// * `self` : 线段树
/// * `l` : 区间起始位置
/// * `r` : 区间结束位置
/// * `value` : 更新值
pub fn update_range[T](self : SegmentTree[T], l : Int, r : Int, value : T) -> Unit {
  self.update_internal(0, 0, self.n - 1, l, r, value)
}

///|
/// 内部更新函数
/// 
/// 参数:
/// * `self` : 线段树
/// * `node` : 当前节点的索引
/// * `start` : 当前节点表示的区间起始位置
/// * `end` : 当前节点表示的区间结束位置
/// * `l` : 更新区间起始位置
/// * `r` : 更新区间结束位置
/// * `value` : 更新值
fn update_internal[T](
  self : SegmentTree[T], 
  node : Int, 
  start : Int, 
  end : Int, 
  l : Int, 
  r : Int, 
  value : T
) -> Unit {
  // 如果更新区间在当前区间之外
  if r < start || end < l {
    return
  }
  
  // 如果更新区间完全包含当前区间
  if l <= start && end <= r {
    self.nodes[node].value = (self.update)(self.nodes[node].value, value)
    
    // 如果不是叶子节点，添加懒惰标记
    if start != end {
      match self.nodes[node].lazy {
        Some(lazy_val) => {
          self.nodes[node].lazy = Some((self.update)(lazy_val, value))
        }
        None => {
          self.nodes[node].lazy = Some(value)
        }
      }
    }
    return
  }
  
  // 传递懒惰标记
  self.push_down(node, start, end)
  
  // 分割当前区间
  let mid = (start + end) / 2
  let left_child = 2 * node + 1
  let right_child = 2 * node + 2
  
  // 递归更新左右子树
  self.update_internal(left_child, start, mid, l, r, value)
  self.update_internal(right_child, mid + 1, end, l, r, value)
  
  // 更新当前节点值
  self.nodes[node].value = (self.merge)(
    self.nodes[left_child].value,
    self.nodes[right_child].value
  )
} 