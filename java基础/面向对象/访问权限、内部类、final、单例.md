```java
// 访问权限（从宽到窄）：
//   public    → 所有类都能访问
//   protected → 同包类 + 不同包的子类（继承关系）能访问
//   default   → 仅同包类能访问（不写权限修饰符就是 default）
//   private   → 仅本类内部能访问
//   ★ protected 比 default 多出的能力：跨包子类也能用，父类遗产不因搬家而收回
//
// final：类不可继承、方法不可重写、变量只能赋值一次（常量）
// 单例：全局唯一实例，禁止外部 new

// ==================== final 演示 ====================
final class MathUtils {
    static final double PI = 3.1415926; // final 变量 → 常量
    static int add(int a, int b) {
        return a + b;
    }
}
// class SubMath extends MathUtils {} // ❌ 报错：final 类不能被继承，final类没有子类

// ========== 内部类 + 单例 综合案例：图书馆管理系统 ==========
// Library 全局唯一（单例），Book 是内部类只服务于 Library
class Library {
    private String name;
    private int bookCount;

    // ==================== 饿汉单例（三要素） ====================
    // 1.private 构造 — 先定义怎么造对象，锁死外部 new 的路径
    private Library(String name) {
         // 构造方法：名字 = 类名，没有返回值
         //构造方法,必须和类名一模一样,返回值绝对不能写，写了就变普通方法,调用方式new 类名()
         //普通方法返回值,必须有（void / int / String...）,调用方式对象.方法名()
        this.name = name;
    }

    // 2. private static  再用构造方法自己new自己，然后再存在自己这里
    private static Library fz = new Library("市立图书馆");

    // 3.public static 统一出口 — 全世界只能通过这里拿实例
    public static Library getFz() {
        return fz;
    }

    // ---------- 内部类 Book ----------
    // 书只属于图书馆，对外部没有独立存在的意义
    class Book {
        private String title;
        private String author;

        Book(String title, String author) {
            this.title = title;
            this.author = author;
            bookCount++; // 内部类直接操作外部类的 private 属性
        }

        void showInfo() {
            // 内部类也可以读取外部类的 private name
            System.out.println("《" + title + "》" + author + " — 馆藏于：" + name);
        }
    }

    // 外部类提供方法，让外界间接创建内部类对象
    public Book addBook(String title, String author) {
        return new Book(title, author);
    }

    public void showCount() {
        System.out.println(name + " 当前藏书：" + bookCount + " 本");
    }
}

// ==================== 使用演示 ====================
public class Demo {
    public static void main(String[] args) {
        // 单例：只能通过 getFz() 获取，不能 new Library()
        Library lib = Library.getFz();

        // 通过 Library 的方法添加书（内部类对外不可见）
        Library.Book b1 = lib.addBook("Java 编程思想", "Bruce Eckel");
        Library.Book b2 = lib.addBook("深入理解 Java 虚拟机", "周志明");

        b1.showInfo();
        b2.showInfo();
        lib.showCount();

        // final 常量
        System.out.println("圆周率 PI = " + MathUtils.PI);
        System.out.println("3 + 5 = " + MathUtils.add(3, 5));
    }
}
```