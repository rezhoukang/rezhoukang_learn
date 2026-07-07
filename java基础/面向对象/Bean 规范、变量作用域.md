```java
// 标准 JavaBean 规范：
//   1. 属性全部 private
//   2. 提供无参构造
//   3. 每个属性配 getXxx() / setXxx()
public class User {
    private String username;
    private int age;

    // 无参构造
    public User(){}

    //这个是有参构造
    // 其实写了无参构造，setter照样可以用，所以有无参构造是基本要求
    // 如果只写了无参，没写有参
    // 这样子效果相同
    // User u = new User(); 
    // u.setUsername("张三");       
    // u.setAge(18);
    // 效果一样，有参本质上是在无参上面封装了一层，为了便利；你可以写你我他这三个字，无参是白纸，某个有参是写了你我的白纸，无参new完之后，可以写你，可以写你我，可以写你他，可以写你我他，但是有参没办法写单独一个他，没办法写你他，所以必须要有无参
    public User(String username, int age) {
        this.username = username;
        this.age = age;
    }

    // getter，调用无参构造
    public String getUsername() {
        return username;
    }
    public int getAge() {
        return age;
    }

    // setter，调用有参构造
    public void setUsername(String username) {
        this.username = username;
    }
    public void setAge(int age) {
        this.age = age;
    }
   //over，然后就构筑起了一个javabean
    public static void main(String[] args) {
        // 无参构造 + setter
        User u1 = new User();
        u1.setUsername("张三");
        u1.setAge(18);
        System.out.println(u1.getUsername() + "，" + u1.getAge() + "岁");

        // 有参构造一步到位
        User u2 = new User("李四", 22);
        System.out.println(u2.getUsername() + "，" + u2.getAge() + "岁");
    }
 
}
```