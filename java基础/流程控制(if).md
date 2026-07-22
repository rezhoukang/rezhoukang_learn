```java
public class D_FlowControl {
    public static void main(String[] args) {
        // ===================== 024 顺序执行：代码从上到下逐行执行，默认逻辑 =====================
        System.out.println("第一行代码"); // 输出：第一行代码
        System.out.println("第二行代码"); // 输出：第二行代码
        System.out.println("第三行代码"); // 输出：第三行代码
        // 顺序执行特点：不写分支、循环时，严格从上至下执行


        // ===================== 025~030 分支执行（if系列 + switch） =====================
        // 026 单分支if：条件成立才执行代码块
        int score1 = 95;
        if (score1 >= 90) {
            System.out.println("单分支：成绩优秀"); // 输出：单分支：成绩优秀
        }

        // 027 双分支if-else：成立走if，不成立走else
        int age = 16;
        if (age >= 18) {
            System.out.println("双分支：成年人");
        } else {
            System.out.println("双分支：未成年人"); // 输出：双分支：未成年人
        }

        // 028 多分支if-else if-else：多区间判断
        int score2 = 78;
        if (score2 >= 90) {
            System.out.println("多分支：A");
        } else if (score2 >= 80) {
            System.out.println("多分支：B");
        } else if (score2 >= 60) {
            System.out.println("多分支：C"); // 输出：多分支：C
        } else {
            System.out.println("多分支：D");
        }

        // 029 特殊多分支switch：匹配固定数值/字符串
        int week = 3;
        switch (week) {
            case 1:
                System.out.println("周一");
                break;
            case 3:
                System.out.println("switch：周三"); // 输出：switch：周三
                break;
            default:
                System.out.println("未知星期");
                break;
        }

        // 030 分支综合小练习：判断奇偶
        int numTest = 11;
        if (numTest % 2 == 0) {
            System.out.println("练习：偶数");
        } else {
            System.out.println("练习：奇数"); // 输出：练习：奇数
        }


        // ===================== 031~035 循环重复执行 =====================
        // 031 while循环：先判断条件，成立再执行
        int w = 1;
        while (w <= 3) {
            System.out.println("while循环：" + w);
            w++;
        }
        /* 输出：
        while循环：1
        while循环：2
        while循环：3
        */

        // 032 do-while循环：先执行一次，再判断条件
        int dw = 1;
        do {
            System.out.println("do-while循环：" + dw);
            dw++;
        } while (dw <= 2);
        /* 输出：
        do-while循环：1
        do-while循环：2
        */

        // 033 for循环：标准计数循环，最常用
        for (int f = 1; f <= 3; f++) {
            System.out.println("for循环：" + f);
        }
        /* 输出：
        for循环：1
        for循环：2
        for循环：3
        */

        // 034 break & continue 跳转关键字
        // break：直接终止整个循环
        for (int b = 1; b <= 5; b++) {
            if (b == 3) {
                break;
            }
            System.out.println("break测试：" + b);
        }
        /* 输出：
        break测试：1
        break测试：2
        */

        // continue：跳过当前这一次循环，直接进入下一轮
        for (int c = 1; c <= 4; c++) {
            if (c == 2) {
                continue;
            }
            System.out.println("continue测试：" + c);
        }
        /* 输出：
        continue测试：1
        continue测试：3
        continue测试：4
        */

        // 035 循环综合练习：九层妖塔（打印9行星号）
        for (int tower = 1; tower <= 9; tower++) {
            for (int star = 1; star <= tower; star++) {
                System.out.print("*");
            }
            System.out.println(); // 换行
        }
        /* 输出金字塔：
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
    }
}
```