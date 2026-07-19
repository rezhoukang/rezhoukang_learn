# Service 层注解

## @Service

标记业务层，进 Bean 容器。被 `@Autowired` 注入到 Controller。

```java
@Service
public class DeptService {
    @Autowired
    private DeptMapper mapper;  // 注入 Mapper

    public Dept getById(Integer id) {
        return mapper.selectById(id);
    }
}
```

Service 是**业务逻辑层**，职责：

- 调 Mapper 拿数据
- 做业务处理（比如判断、计算、组合多个 Mapper 调用）
- 把结果返回给 Controller

## @Transactional

标记方法或类，**事务管理**——方法内多个 SQL 要么全成功，要么全回滚。

```java
@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private StockMapper stockMapper;

    @Transactional  // 下单 + 扣库存，任何一个失败都回滚
    public void createOrder(Order order) {
        orderMapper.insert(order);
        stockMapper.deduct(order.getProductId());  // 如果这里抛异常，上面的 insert 也撤回
    }
}
```

**不加 `@Transactional`：** 扣库存失败了，订单已经存进去了——数据不一致。

**加了 `@Transactional`：** 扣库存失败 → 自动抛异常 → 订单插入也撤销 → 数据安全。

## Service 层常见代码

```java
@Service
public class DeptService {

    @Autowired
    private DeptMapper mapper;

    // 查
    public Dept get(Integer id) { return mapper.selectById(id); }

    // 查全部
    public List<Dept> list() { return mapper.selectList(null); }

    // 增
    public void add(Dept dept) { mapper.insert(dept); }

    // 改
    @Transactional
    public void edit(Dept dept) { mapper.updateById(dept); }

    // 删
    public void delete(Integer id) { mapper.deleteById(id); }
}
```
