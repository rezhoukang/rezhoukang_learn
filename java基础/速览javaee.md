# 整合梳理 + Java SE 完整释义
## 1. 各层级完整定义
1.JVM：Java Virtual Machine
中文：Java 虚拟机
Java虚拟机，负责解析、执行 `.class` 字节码，跨平台核心。
基座

JRE：Java Runtime Environment
中文：Java 运行环境
JRE = JVM + Java SE 标准类库
JVM 集成在 JRE 里面，不是分开两个独立安装包
仅运行环境，无编译工具，只能执行已编译好的普通Java程序。
用于run

3. JDK：Java Development Kit
中文：Java 开发工具包
JDK = JRE + 开发工具（javac编译器、调试、打包工具等）
用于build+run
jre集成在了jdk里面
完整 Java SE 开发套件，写、编译、运行普通Java程序都靠它。

4. **Java SE = Java Standard Edition，Java 标准版**

是一整套基础平台规范。包含：JVM、JRE、JDK、Java基础标准库（IO、集合、线程、网络、日期等基础API）。

5. **Java EE = Java Platform, Enterprise Edition，Java 平台企业版**

依赖 Java SE 作为底层基础，在 SE 之上新增一套企业级规范API：Servlet、JPA、JTA、JMS、Web、分布式事务等。

.java：开发阶段产物，依赖 JDK（有 javac 编译器）
.class：编译后产物，只需要 JRE+JVM 就能运行，不需要编译器