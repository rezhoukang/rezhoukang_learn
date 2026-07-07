```java
// 044 static静态：属于类，所有对象共享；非static属于单个对象
class Person {
    // 实例属性（每个对象独立）
    String name;
    // 静态属性（全局唯一）
    static String className = "一班";

    // 静态代码块 045：类加载时只执行1次，优先于对象执行
    static {
        System.out.println("静态代码块执行"); // 程序启动先打印这行
    }

    // 静态方法：只能访问静态成员，不能直接用this
    public static void showClass() {
        System.out.println("班级：" + className);
    }
    // 实例方法：可访问静态、非静态（this 指向当前对象）
    public void showName() {
        System.out.println(this.name + "，班级：" + className);
    }
}

// 046 包：文件夹，管理类；047 import导入其他包的类
// import java.util.Scanner; // 导包写法，否则要写全类名java.util.Scanner
public class E2_StaticPackage {
    public static void main(String[] args) {
        // 静态成员直接用 类名. 调用，无需创建对象
        System.out.println(Person.className); // 输出：一班
        Person.showClass(); // 输出：班级：一班

        Person p1 = new Person();
        p1.name = "小明";
        p1.showName(); // 输出：小明，班级：一班
    }
}
```