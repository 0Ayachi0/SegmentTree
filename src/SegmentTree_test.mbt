// SegmentTree_test.mbt - 线段树测试文件

///|
/// 测试线段树的基本功能
test "线段树基本功能测试" {
  // 创建测试数组
  let arr = [1, 3, 5, 7, 9, 11]
  
  // 创建线段树
  let st = new(
    arr,
    fn(a : Int, b : Int) -> Int { a + b },     // 合并操作：求和
    fn(a : Int, b : Int) -> Int { a + b },     // 更新操作：增加值
    0                                         // 默认值：0
  )
  
  // 测试查询功能
  let sum_total = st.query(0, 5)
  inspect!(sum_total, content="36")  // 整个数组的和应为36
  
  let sum_partial = st.query(1, 3)
  inspect!(sum_partial, content="15")  // 索引1到3的和应为15
  
  // 测试单点更新
  st.update_point(2, 10)  // 将索引2处的值增加10
  let new_sum = st.query(0, 5)
  inspect!(new_sum, content="46")  // 更新后的总和应为46
  
  // 测试区间更新
  st.update_range(3, 5, 2)  // 将索引3到5的元素都增加2
  let final_sum = st.query(0, 5)
  inspect!(final_sum, content="48")  // 最终的总和应为48
}

///|
/// 测试区间最大值
test "区间最大值测试" {
  let arr = [3, 1, 8, 4, 6, 2]
  
  // 创建用于求最大值的线段树
  let st = new(
    arr,
    fn(a : Int, b : Int) -> Int { if a > b { a } else { b } },  // 合并操作：取最大值
    fn(a : Int, b : Int) -> Int { a + b },                      // 更新操作：增加值
    -9999999                                                   // 默认值：一个很小的数
  )
  
  // 测试查询最大值
  let max_total = st.query(0, 5)
  inspect!(max_total, content="8")  // 整个数组的最大值应为8
  
  let max_partial = st.query(3, 5)
  inspect!(max_partial, content="6")  // 索引3到5的最大值应为6
  
  // 测试更新后的最大值变化
  st.update_point(5, 7)  // 将索引5处的值增加7
  let new_max = st.query(0, 5)
  inspect!(new_max, content="9")  // 更新后的最大值应为9
  
  st.update_range(0, 2, 5)  // 将索引0到2的元素都增加5
  let final_max = st.query(0, 5)
  inspect!(final_max, content="13")  // 最终的最大值应为13
}

///|
/// 测试区间最小值
test "区间最小值测试" {
  let arr = [9, 3, 7, 1, 8, 5]
  
  // 创建用于求最小值的线段树
  let st = new(
    arr,
    fn(a : Int, b : Int) -> Int { if a < b { a } else { b } },  // 合并操作：取最小值
    fn(a : Int, b : Int) -> Int { a + b },                      // 更新操作：增加值
    9999999                                                    // 默认值：一个很大的数
  )
  
  // 测试查询最小值
  let min_total = st.query(0, 5)
  inspect!(min_total, content="1")  // 整个数组的最小值应为1
  
  let min_partial = st.query(0, 2)
  inspect!(min_partial, content="3")  // 索引0到2的最小值应为3
  
  // 测试更新后的最小值变化
  st.update_point(3, 10)  // 将索引3处的值增加10
  let new_min = st.query(0, 5)
  inspect!(new_min, content="3")  // 更新后的最小值应为3
  
  st.update_range(0, 2, -2)  // 将索引0到2的元素都减少2
  let final_min = st.query(0, 5)
  inspect!(final_min, content="1")  // 最终的最小值应为1
}

///|
/// 测试不同的更新操作
test "不同更新操作测试" {
  let arr = [10, 20, 30, 40, 50]
  
  // 创建线段树，使用赋值作为更新操作而不是增加
  let st = new(
    arr,
    fn(a : Int, b : Int) -> Int { a + b },     // 合并操作：求和
    fn(_ : Int, b : Int) -> Int { b },         // 更新操作：赋值（直接使用新值）
    0                                         // 默认值：0
  )
  
  // 测试初始状态
  let initial_sum = st.query(0, 4)
  inspect!(initial_sum, content="150")  // 初始总和应为150
  
  // 测试单点赋值更新
  st.update_point(2, 100)  // 将索引2的值设置为100
  let new_sum = st.query(0, 4)
  inspect!(new_sum, content="220")  // 更新后的总和应为220
  
  let point_value = st.query(2, 2)
  inspect!(point_value, content="100")  // 索引2的值应为100
  
  // 测试区间赋值更新
  st.update_range(0, 2, 5)  // 将索引0到2的元素都设置为5
  let final_sum = st.query(0, 4)
  inspect!(final_sum, content="95")  // 最终的总和应为95 (5+5+5+40+50=95)
  
  let range_sum = st.query(0, 2)
  inspect!(range_sum, content="5")  // 索引0到2的和应为5
}

///|
/// 测试单元素数组
test "单元素数组测试" {
  // 测试：单元素数组
  let single_arr = [42]
  let single_st = new(
    single_arr,
    fn(a : Int, b : Int) -> Int { a + b },
    fn(a : Int, b : Int) -> Int { a + b },
    0
  )
  
  let single_value = single_st.query(0, 0)
  inspect!(single_value, content="42")  // 单元素值应为42
  
  single_st.update_point(0, 10)  // 增加10
  let new_single_value = single_st.query(0, 0)
  inspect!(new_single_value, content="52")  // 更新后的值应为52
} 