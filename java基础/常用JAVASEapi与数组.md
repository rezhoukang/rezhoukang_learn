
```java
import java.util.Arrays;
import java.util.Date;
import java.util.Calendar;
import java.util.ArrayList;

public class F_ArrayAndCommonClass {
    public static void main(String[] args) {
        // ===================== 070 Object 所有类的根父类 =====================
        Object obj = new String("我是Object子类");
        System.out.println(obj.toString()); // 输出：我是Object子类
        // 所有自定义类、String、数组都直接/间接继承Object

        // ===================== F1 数组全套 071~076 =====================
        // 071 一维数组 3种定义方式
        int[] arr1 = {10,20,30}; // 静态初始化
        int[] arr2 = new int[3]; // 动态初始化，默认值0
        arr2[0] = 66;
        System.out.println("一维数组第一个元素：" + arr1[0]); // 输出：一维数组第一个元素：10
        System.out.println("数组长度：" + arr1.length); // 输出：数组长度：3

        // 072 二维数组
        int[][] twoArr = {{1,2},{3,4}};
        System.out.println("二维数组第二行第一个：" + twoArr[1][0]); // 输出：二维数组第二行第一个：3

        // 073 九层妖塔 二维嵌套循环（复用流程控制逻辑）
        System.out.println("=====九层妖塔=====");
        for(int i = 1; i <= 9; i++){
            for(int j = 1; j <= i; j++){
                System.out.print("*");
            }
            System.out.println();
        }
        /* 输出金字塔
        *
        **
        ***
        ****
        *****
        ******
        *******
        ********
        *********
        */

        // 074 冒泡排序：相邻两两比较交换，升序
        int[] bubbleArr = {5,2,9,1,5,6};
        for(int i = 0; i < bubbleArr.length - 1; i++){
            for(int j = 0; j < bubbleArr.length - 1 - i; j++){
                if(bubbleArr[j] > bubbleArr[j+1]){
                    int temp = bubbleArr[j];
                    bubbleArr[j] = bubbleArr[j+1];
                    bubbleArr[j+1] = temp;
                }
            }
        }
        System.out.println("冒泡排序后：" + Arrays.toString(bubbleArr)); // 输出：冒泡排序后：[1, 2, 5, 5, 6, 9]

        // 075 选择排序：固定最小值下标，一轮结束交换一次
        int[] selectArr = {8,3,1,4};
        for(int i = 0; i < selectArr.length - 1; i++){
            int minIndex = i;
            for(int j = i+1; j < selectArr.length; j++){
                if(selectArr[j] < selectArr[minIndex]){
                    minIndex = j;
                }
            }
            int temp = selectArr[i];
            selectArr[i] = selectArr[minIndex];
            selectArr[minIndex] = temp;
        }
        System.out.println("选择排序后：" + Arrays.toString(selectArr)); // 输出：选择排序后：[1, 3, 4, 8]

        // 076 二分查找：前提数组有序，对半缩小查找范围
        int[] binaryArr = {1,3,5,7,9,11};
        int target = 7;
        int left = 0, right = binaryArr.length - 1;
        int index = -1;
        while(left <= right){
            int mid = (left + right) / 2;
            if(binaryArr[mid] == target){
                index = mid;
                break;
            }else if(binaryArr[mid] < target){
                left = mid + 1;
            }else{
                right = mid - 1;
            }
        }
        System.out.println("二分查找7的下标：" + index); // 输出：二分查找7的下标：3


        // ===================== F2 String字符串全套 077~084 =====================
        String str = "JavaStudy";
        // 078 字符串拼接
        String strJoin = str + "2026";
        System.out.println("拼接：" + strJoin); // 输出：拼接：JavaStudy2026

        // 079 字符串比较 ==与equals
        String s1 = "abc";
        String s2 = new String("abc");
        System.out.println("==比较地址：" + (s1 == s2)); // 输出：==比较地址：false
        System.out.println("equals比较内容：" + s1.equals(s2)); // 输出：equals比较内容：true

        // 080 截取 substring(起始下标,结束下标)
        String subStr = str.substring(0,4);
        System.out.println("截取前四位：" + subStr); // 输出：截取前四位：Java

        // 081 替换 replace
        String replaceStr = str.replace("Study", "学习");
        System.out.println("替换后：" + replaceStr); // 输出：替换后：Java学习

        // 082 大小写转换
        System.out.println("全部大写：" + str.toUpperCase()); // 输出：全部大写：JAVASTUDY
        System.out.println("全部小写：" + str.toLowerCase()); // 输出：全部小写：javastudy

        // 083 查询相关方法
        System.out.println("字符a下标：" + str.indexOf('a')); // 输出：字符a下标：1
        System.out.println("是否包含Java：" + str.contains("Java")); // 输出：是否包含Java：true

        // 084 StringBuilder 字符串拼接高效工具，可变字符串
        StringBuilder sb = new StringBuilder();
        sb.append("Hello");
        sb.append(" World");
        String sbResult = sb.toString();
        System.out.println("StringBuilder拼接结果：" + sbResult); // 输出：StringBuilder拼接结果：Hello World


        // ===================== F3 包装类、日期、工具类 085~089 =====================
        // ===== 包装类 =====
        // 8个基本类型 → 8个包装类：int→Integer, double→Double, char→Character, boolean→Boolean ...
        // String 本身就是引用类型（对象），不是包装类，不需要包装
        // 包装类的核心原因：数据库字段可能为null，基本类型int不能null，Integer可以
        Integer numWrap = 100; // 自动装箱 int→Integer
        int numUnWrap = numWrap; // 自动拆箱 Integer→int
        System.out.println("包装类拆箱数值：" + numUnWrap);

        // 包装类用途①：集合必须用包装类（数组长度固定不方便，集合自动扩容）
        // int[] arr = new int[3]; arr[3]=90; // ❌ 数组越界
        // ArrayList<int> err = new ArrayList<>(); // ❌ 基本类型不行
        ArrayList<Integer> listNum = new ArrayList<>();
        listNum.add(10);
        listNum.add(20);
        listNum.add(30);
        listNum.add(40); // ✅ 自动扩容
        System.out.println("集合第一个数：" + listNum.get(0));

        // 包装类用途②：可存null，基本类型不行（应对数据库null）
        Integer canBeNull = null; // ✅
        // int cannotBeNull = null; // ❌
        System.out.println("null值：" + canBeNull);

        // 086 Date 日期类
        Date nowDate = new Date();
        System.out.println("当前系统时间：" + nowDate); // 输出：当前系统时间：Wed Jul 07 ...

        // 087/088 Calendar日历类
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH)+1; // 月份从0开始，+1修正
        System.out.println("当前年月：" + year + "年" + month + "月"); // 输出：当前年月：2026年7月

        // 089 工具类示例 Arrays数组工具类
        int[] toolArr = {2,5,1};
        Arrays.sort(toolArr);
        System.out.println("工具类排序：" + Arrays.toString(toolArr)); // 输出：工具类排序：[1, 2, 5]

   
    }
}
```
> **String 不是包装类**。包装类只有 8 个，对应 8 个基本类型：
> `int→Integer`、`double→Double`、`char→Character`、`boolean→Boolean` 等
> String 本身就是引用类型（对象），不是基本类型，不需要包装，直接就能放集合、存 null。
>
> **包装类主要是为了应付数据库的 null** — 数据库字段可能为 NULL，基本类型 int 不能为 null，
> 用 Integer 才能正确表示"空"。集合必须用包装类也是因为集合只接受对象，而数据库数据经常用集合装。
>  泛型总结：泛型只存在于编译阶段，用于类型检查，编译成 .class 后泛型被擦除，运行时全是同一个类