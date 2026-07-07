```java
// 036 面向对象介绍：一切皆对象，类是模板，对象是实例
// 037 基础语法：先定义类，再new创建对象
class Student {
    // 040 属性（成员变量）：描述事物特征
    String name;
    int age;

    // 041 无参方法（无参数）：描述事物行为
    void showInfo() {
        System.out.println("姓名：" + name + "，年龄：" + age);
    }

    // 042 带参数方法：方法接收外部传入数据
    void setAge(int a) { // a是形参
        age = a;
    }

    // 043 传值方式：基本类型值传递，引用类型地址传递
    void changeNum(int num) {
        num = 999; // 仅修改副本，不影响外部变量
    }
    void changeName(Student s) {
        s.name = "李四"; // 修改对象地址指向的数据
    }
}

public class E1_OOPBase {
    public static void main(String[] args) {
        // new 创建对象（实例化）
        Student s1 = new Student();
        // 给属性赋值
        s1.name = "张三";
        s1.setAge(18);
        s1.showInfo(); // 输出：姓名：张三，年龄：18

        // 测试基本类型传值
        int x = 10;
        s1.changeNum(x);
        System.out.println("基本类型传值后x：" + x); // 输出：基本类型传值后x：10

        // 测试引用类型传值
        Student s2 = new Student();
        s2.name = "王五";
        s1.changeName(s2);
        System.out.println("引用类型传值后name：" + s2.name); // 输出：引用类型传值后name：李四
    }
}
```