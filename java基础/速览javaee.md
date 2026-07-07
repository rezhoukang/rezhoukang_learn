
# 速览 Java EE

### 1. JVM — Java Virtual Machine（Java 虚拟机）

- 负责解析、执行 `.class` 字节码，是**跨平台核心**。
- 位于最底层，是整个 Java 体系的**基座**。

### 2. JRE — Java Runtime Environment（Java 运行环境）

- **JRE = JVM + Java SE 标准类库**
- JVM 集成在 JRE 内部，不是两个独立安装包。
- 仅提供**运行环境**，无编译工具，只能执行已编译好的普通 Java 程序。
- 用途：**run**

### 3. JDK — Java Development Kit（Java 开发工具包）

- **JDK = JRE + 开发工具**（javac 编译器、调试器、打包工具等）
- JRE 集成在 JDK 内部。
- 完整的 Java SE 开发套件，编写、编译、运行普通 Java 程序都靠它。
- 用途：**build + run**

### 4. Java SE — Java Standard Edition（Java 标准版）

- 一整套**基础平台规范**。
- 包含：JVM、JRE、JDK，以及 Java 基础标准库（IO、集合、线程、网络、日期等基础 API）。

### 5. Java EE — Java Platform, Enterprise Edition（Java 平台企业版）

- 依赖 Java SE 作为底层基础，在其之上新增一套**企业级规范 API**。
- 包括：Servlet、JPA、JTA、JMS、Web 服务、分布式事务等。

---
---

- **开发阶段**：`.java` 源文件 → 依赖 JDK（内含 javac 编译器）
- **运行阶段**：`.class` 字节码 → 依赖 JRE + JVM（无需编译器）