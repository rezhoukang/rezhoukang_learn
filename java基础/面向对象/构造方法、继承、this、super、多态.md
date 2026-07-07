```java
// 父类（被继承）
class Animal {
    String name;
    // 048 构造方法：与类同名，无返回值，new时自动调用，用于初始化属性
    public Animal(String name) {
        this.name = name; // this：代表当前对象
    }
    void eat() {
        System.out.println("动物吃东西");
    }
}

// 049 继承 extends：子类复用父类代码
class Dog extends Animal {
    // 子类构造必须通过super调用父类构造 050/051
    public Dog(String name) {
        super(name); // super：代表父类对象，必须放在第一行
    }
    // 052 多态：子类重写父类方法，运行执行子类逻辑
    @Override
    void eat() {
        System.out.println(name + "啃骨头");
    }
}

public class E3_ExtendSuper {
    public static void main(String[] args) {
        // 多态写法：父类引用指向子类对象
        Animal dog = new Dog("旺财");
        dog.eat(); // 输出：旺财啃骨头（执行子类重写方法）
    }
}
```