```java
import java.io.*;

public class I_IOAll {
    public static void main(String[] args) {
        // ===================== 118 IO流介绍 =====================
        /*
        IO = Input输入(读文件) / Output输出(写文件)
        分类：
        1.字节流：InputStream/OutputStream，万能，所有文件（图片/视频/文本）
        2.字符流：Reader/Writer，仅处理txt文本，不能处理媒体文件
        */
        // File：代表文件/文件夹路径（不一定真实存在）
        File file = new File("test.txt");
        System.out.println("文件是否存在：" + file.exists()); // 首次运行输出：false
        try {
            // 创建空文件（文件已存在则返回false）
            boolean create = file.createNewFile();
            System.out.println("文件创建成功？" + create); // 首次运行输出：true
        } catch (IOException e) {
            e.printStackTrace();
        }


        // ===================== 119/120 基础字节流：写入文件、读取文件、文件复制 =====================
        // 1. 字节输出流：向test.txt写入字节数据
        try (FileOutputStream fos = new FileOutputStream("test.txt")) {
            fos.write(97); // 写入字母a的ASCII码
            fos.write("你好IO".getBytes()); // 写入字符串转为字节数组
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 2. 字节输入流：读取文件内容
        try (FileInputStream fis = new FileInputStream("test.txt")) {
            byte[] buf = new byte[1024]; // 缓冲区数组，一次读1024字节
            int len = fis.read(buf); // len代表本次读到的字节长度
            String content = new String(buf, 0, len);
            System.out.println("字节流读取文件：" + content); // 输出：字节流读取文件：a你好IO
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 3. 文件复制（120 文件复制案例）：读取原文件，写入新文件
        try (FileInputStream fisCopy = new FileInputStream("test.txt");
             FileOutputStream fosCopy = new FileOutputStream("copy_test.txt")) {
            byte[] buf = new byte[1024];
            int len;
            while ((len = fisCopy.read(buf)) != -1) { // read返回-1代表读到文件末尾
                fosCopy.write(buf, 0, len);
            }
            System.out.println("文件复制完成"); // 输出：文件复制完成
        } catch (IOException e) {
            e.printStackTrace();
        }


        // ===================== 121 缓冲流Buffered：底层自带缓冲区，大幅提升读写速度 =====================
        // 没缓冲流：每write一次就写一次硬盘，很慢；缓冲流：在内存开个临时仓库(默认8K)，攒够了一次性刷进硬盘
        // 就像搬砖——没缓冲流=搬一块跑一趟；缓冲流=搬十块跑一趟。数据量越大缓冲流优势越明显
        // 缓冲字节输出流
        try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("buf.txt"))) {
            bos.write("缓冲流写入内容".getBytes());
            bos.flush(); // 强制刷新缓冲区，把数据刷进硬盘
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 缓冲字节输入流读取
        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream("buf.txt"))) {
            byte[] buf = new byte[1024];
            int len = bis.read(buf);
            System.out.println("缓冲流读取：" + new String(buf,0,len)); // 输出：缓冲流读取：缓冲流写入内容
        } catch (IOException e) {
            e.printStackTrace();
        }


        // ===================== 122 字符流Reader/Writer：只操作文本文件 =====================
        // 字符写入
        try (FileWriter fw = new FileWriter("char.txt")) {
            fw.write("字符流只能处理文本");
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 字符读取
        try (FileReader fr = new FileReader("char.txt")) {
            char[] cBuf = new char[1024];
            int len = fr.read(cBuf);
            System.out.println("字符流读取：" + new String(cBuf,0,len)); // 输出：字符流读取：字符流只能处理文本
        } catch (IOException e) {
            e.printStackTrace();
        }


        // ===================== 123 序列化流 ObjectOutputStream：把对象存入文件 =====================
        // 前提：实体类实现Serializable接口
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("obj.txt"))) {
            User user = new User("张三", 18);
            oos.writeObject(user); // 将对象写入文件
            System.out.println("对象序列化存入文件"); // 输出：对象序列化存入文件
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 反序列化：从文件读取对象
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("obj.txt"))) {
            User readUser = (User) ois.readObject();
            System.out.println("反序列化读取对象：" + readUser.name + " " + readUser.age); // 输出：反序列化读取对象：张三 18
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }


        // ===================== 124 IO常见异常统一处理规范 =====================
        /*
        1. IO操作必须捕获/抛出IOException（检查时异常）
        2. 资源流用完必须关闭，推荐try-with-resources自动关闭（本代码全部使用该写法）
        3. 文件不存在、权限不足、路径错误都会抛出IO异常
        */
    }
}

// 序列化要求：实体类实现Serializable标记接口
//序列化 = 把 Java 对象转成字节流（可以存入文件或网络传输）
//这个 User 类就是被序列化和反序列化的那个对象。
class User implements Serializable {
    String name;
    int age;
    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```
> **空接口（标记接口）**：大括号里啥都没有，只贴个标签告诉 Java 这个类有某种性质。
>
> ```java
> // 空接口 — 不用重写任何方法，只贴标签
> public interface Serializable { /* 空的 */ }
>
> // 普通接口 — 有方法声明，实现类必须重写
> interface Play {
>     void game();
>     void watch();
> }
> ```
>
> `Serializable` = "允许被序列化"；`Cloneable` = "允许被克隆"。
> **有方法的接口 → 你必须重写；空接口 → 只需要挂个名，不用写任何代码。**