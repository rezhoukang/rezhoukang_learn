## 8. CSS简介及导入方式
### 核心知识点
1. CSS全称层叠样式表，作用：美化HTML、控制页面布局，实现结构与样式分离
2. 三种导入方式、优先级：内联样式 > 内部样式表 > 外部样式表
3. 加载顺序会覆盖同权重样式，但不改变三种导入方式的基础层级权重
### 完整演示代码
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>三种CSS导入演示</title>
  <!-- 外部样式表 -->
  <link rel="stylesheet" href="style.css">
  <!-- 内部样式表 -->
  <style>
    .box {
      color: blue;
      font-size: 22px;
    }
  </style>
</head>
<body>
  <!-- 内联样式 -->
  <div class="box" style="color: red; font-size: 30px;">优先级：内联 > 内部 > 外部</div>
</body>
</html>
```
配套 `style.css`（外部文件）
```css
.box {
  color: green;
  font-size: 14px;
}
```
### 效果
文字最终红色30px，内联样式权重最高。

---

## 9. CSS选择器
### 核心知识点
1. 基础选择器：通配符`*`、标签、类`.class`、ID`#id`
   - class可重复使用，ID页面唯一
2. 组合选择器：后代(空格)、子代(>)、相邻兄弟(+)
   - 后代：选所有子孙，不限层级
   - 子代：只选直接儿子
   - 相邻兄弟：选紧挨着的下一个
3. 伪类`:`描述元素状态（hover悬停、focus聚焦、first-child第一个子元素等）
4. 伪元素`::`在元素内凭空创建不存在的东西（before前插、after后插）
5. 权重：ID(100) > 类/伪类(10) > 标签(1)
### 完整演示代码
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>CSS选择器</title>
  <style>
    /* ===== 基础选择器 ===== */
    * { margin: 10px; }          /* 通配符 — 所有元素 */
    p { color: gray; }           /* 标签选择器 — 所有<p> */
    .text { font-size: 20px; }   /* 类选择器 — class="text" */
    #title { color: orange; }    /* ID选择器 — id="title"（唯一）*/

    /* ===== 组合选择器 ===== */
    .wrap div { }                /* 后代(空格) — .wrap里面所有div */
    .wrap > div { border: 1px solid #000; } /* 子代(>) — 只选直接儿子 */
    h2 + p { color: green; }     /* 相邻兄弟(+) — h2后面紧挨着的p */

    /* ===== 伪类 ===== */
    .btn:hover { background: skyblue; }         /* 鼠标悬停 */
    input:focus { border-color: red; }          /* 输入框聚焦时 */
    .list li:first-child { color: red; }        /* 第一个li */
    .list li:last-child { color: blue; }        /* 最后一个li */
    .list li:nth-child(2) { color: green; }     /* 第2个li */

    /* ===== 伪元素 ===== */
    .tip::before { content: "提示："; color: red; }  /* 内容前插入文字 */
    .tip::after { content: " *"; color: orange; }     /* 内容后插入文字 */
  </style>
</head>
<body>
  <h2 id="title">ID选择器标题</h2>
  <p class="text">类+标签选择器文本</p>

  <div class="wrap">
    <div>子代元素（直接儿子）</div>
  </div>

  <h2>标题</h2>
  <p>这个p变绿（相邻兄弟）</p>
  <p>这个p不变</p>

  <button class="btn">鼠标悬浮变色</button>
  <br>
  <input placeholder="点击我聚焦变红边框">

  <ul class="list">
    <li>第一项（红）</li>
    <li>第二项（绿）</li>
    <li>第三项</li>
    <li>最后一项（蓝）</li>
  </ul>

  <div class="tip">伪元素测试</div>
  <!-- 显示："提示：伪元素测试 *" -->
</body>
</html>
```

---

## 10. CSS常用属性
### 核心知识点
文字、背景、边框、基础显示四大类属性
### 完整演示代码
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>常用样式属性</title>
  <style>
    .demo {
      /* ===== 文字属性 ===== */
      color: #333;                    /* 字体颜色（十六进制深灰） */
      font-size: 18px;               /* 字体大小 */
      font-weight: bold;             /* 加粗（也可用数字 700） */
      line-height: 2;                /* 行高（2 = 字体大小的2倍） */
      text-align: center;            /* 文字水平居中 */
      text-indent: 2em;              /* 首行缩进2个字符 */

      /* ===== 背景属性 ===== */
      background-color: #eee;        /* 背景色（浅灰） */
      background-image: url("");     /* 背景图片（空字符串不显示） */
      background-size: cover;        /* 背景图铺满容器，按比例裁剪 */

      /* ===== 边框 ===== */
      border: 2px solid #666;        /* 边框：粗细 样式 颜色 */
      border-radius: 8px;            /* 圆角（值越大越圆） */

      /* ===== 透明度和尺寸 ===== */
      opacity: 0.9;                  /* 不透明度（1=不透明，0=透明） */
      width: 400px;                  /* 宽度 */
      height: 150px;                 /* 高度 */
    }
  </style>
</head>
<body>
  <div class="demo">这是一段测试文本，演示文字、背景、边框全部基础属性</div>
</body>
</html>
```

---

## 11. 盒子模型
### 核心知识点
1. 盒子四部分：content内容、padding内边距、border边框、margin外边距
2. `box-sizing`切换标准盒/怪异盒
3. margin塌陷问题
### 完整演示代码
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>盒子模型</title>
  <style>
    /* 标准盒 — width只算内容，padding+border往外撑，容易超边界 */
    /* 默认就是标准盒（content-box），不写 box-sizing 就是它 */
    .box1 {
      width: 200px;
      height: 100px;
      padding: 20px;
      border: 5px solid red;
      margin: 30px;
      box-sizing: content-box;
      background: #ccc;
    }
    /* 怪异盒 — width/height包含内容+padding+border，设多少就是多少 */
    /* 反直觉但更好用：内容被挤小也不怕，等于设定了一个安全区域，不会触碰到外边界 */
    /* 一个元素可绑多个class：<div class="box2 text-style">内容</div> */
    /* .text-style { color: red; font-weight: bold; } 文字样式单独一个类 */
    .box2 {
      width: 200px;
      height: 100px;
      padding: 20px;
      border: 5px solid blue;
      margin: 30px;
      box-sizing: border-box;
      background: #aaa;
    }

  </style>
</head>
<body>
  <div class="box1">标准盒</div>
  <div class="box2">怪异盒</div>
</body>
</html>
```

---

## 12. 浮动 Float
### 核心知识点
1. `float:left/right`元素脱离标准流，横向排列
2. 浮动父级高度塌陷，多种清除浮动方案
### 完整演示代码（导航栏+清除浮动）
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>浮动与清除浮动</title>
  <style>
    li {
      list-style: none;
      float: left;          /* ① 脱离标准流，从左往右横着排 */
    }
    /* ② 子元素float后父级ul高度塌陷→背景色#333显示不出来 */
    /* ③ overflow:hidden 清除浮动，让ul重新包裹住浮动子元素 */
    ul {
      overflow: hidden;
      background: #333;
      padding: 0;
    }
    li a {
      display: block;       /* 块级才能设padding 按钮什么的想用padding也是先display成block*/
      color: #fff;          /* 白色文字 */
      padding: 12px 24px;   /* 加大点击区域 */
      text-decoration: none;/* 去掉下划线 因为a标签默认有下划线*/
    }
    li a:hover { background: #666; }  /* 鼠标悬停变灰 */
  </style>
</head>
<body>
  <ul>
    <li><a href="#">首页</a></li>
    <li><a href="#">产品</a></li>
    <li><a href="#">关于我们</a></li>
  </ul>
</body>
</html>
```

### 万能清除浮动类（全局通用，推荐）
```css
.clearfix::after {
  content: "";       /* 伪元素生成空内容 */
  display: block;    /* 块级元素占一行 */
  clear: both;       /* 禁止两侧有浮动元素，撑起父级高度 */
}
/* overflow:hidden 有时会切掉溢出的内容，clearfix 伪元素方案通杀所有场景 */
```

---

## 13. 定位 Position
### 核心知识点
5种定位：static、relative、absolute、fixed、sticky；z-index层级
### 完整演示代码（悬浮按钮+吸顶导航+弹窗）
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>定位布局</title>
  <style>
    /* ===== 相对定位 ===== */
    .relative-box {
      width: 200px;                 /* 宽 */
      height: 100px;                /* 高 */
      background: skyblue;          /* 背景色 */
      position: relative;           /* 相对定位：相对于自己原来的位置偏移 */
      top: 20px;                    /* 向下偏移20px */
      left: 20px;                   /* 向右偏移20px */
    }

    /* ===== 绝对定位 =====
    默认盒子是竖着一个一个排列的 */
    /* 相对位置就是relative，在自己原本一个一个排列的位置基础上上下左右移动 */
    /* absolute 在父盒子内部定位，就近原则找最近的定位祖先 */
    /* 父盒子可以是 relative/absolute/fixed/sticky，找不到就参考 body */
    .parenthaahah {
      width: 400px;
      height: 200px;
      background: #eee;
      position: relative;           /* 父级设relative，作为绝对定位的参考点 */
      margin: 50px 0;               /* 上下间距50px 左右间距0*/
    }
    .hahachildha {
      width: 80px;                  /* 宽 */
      height: 80px;                 /* 高 */
      background: orange;           /* 背景色 */
      position: absolute;           /* 绝对定位：相对于最近的定位父级 */
      right: 0;                     /* 贴紧父级右侧 */
      bottom: 0;                    /* 贴紧父级底部 默认不写的话就是左上*/
    }

    /* ===== fixed固定定位：从头到尾钉在窗口上，不随滚动移动 ===== */
    .fixed-btn {
      position: fixed;              /* 固定定位：相对于浏览器窗口 */
      right: 30px;                  /* 距离窗口右侧30px */
      bottom: 30px;                 /* 距离窗口底部30px */
      width: 50px;                  /* 宽 */
      height: 50px;                 /* 高 */
      background: red;              /* 红色背景 */
      border-radius: 50%;           /* 50%圆角→正圆形 */
      color: #fff;                  /* 白色文字 */
      text-align: center;           /* 文字水平居中 */
      line-height: 50px;            /* 行高=高度→文字垂直居中 */
    }

    /* ===== sticky粘性定位：先正常滚动，到top/bottom位置才吸住 ===== */
    /* 跟fixed区别：fixed从头钉到尾；sticky先滚动后固定，不一定是顶部，top:100px就在100px处吸住 */
    .sticky-nav {
      position: sticky;             /* 粘性定位：滚动到指定位置后固定 */
      top: 0;                       /* 到达窗口顶部时吸住 */
      height: 40px;                 /* 高 */
      background: #000;             /* 黑色背景 */
      color: #fff;                  /* 白色文字 */
      line-height: 40px;            /* 文字垂直居中 */
    }
  </style>
</head>
<body>
  <div class="sticky-nav">吸顶导航栏</div>
  <div class="relative-box">相对定位盒子</div>
  <div class="parenthaahah">
    父容器
    <div class="hahachildha">绝对定位子元素</div>
  </div>
  <div class="fixed-btn">↑</div>
  <div style="height: 1200px;">滚动页面测试sticky和fixed</div>
</body>
</html>
```

# 工程化补充说明
即便使用Vue/React框架，上述全部底层规则完全生效：
- Vue `:style` = 内联样式
- `.vue` 文件 `<style>` = 内部样式表
- `import './global.css'` = 外部样式表
- 浮动、定位、盒子模型、选择器权重在组件样式、UI库调试中高频使用。

---

## 附：CSS 单位解读

### `px` — 绝对单位
```css
width: 200px;   /* 打死都是 200 像素，不管字体多大、屏幕多宽 */
```
- 固定不变，最直观
- 不适合响应式布局（不同屏幕大小表现不一样）

### `em` — 相对当前字体大小
```css
font-size: 20px;
padding: 2em;   /* = 2 × 20px = 40px */
```
- **1em = 当前元素的 font-size**
- 字体变大 → em 自动变大，间距跟着走
- 适合首行缩进、按钮内边距等需要"跟着字体走"的场景

### `rem` — 相对根元素字体大小
```css
html { font-size: 16px; }       /* 根元素设基准 */

.title { font-size: 2rem; }     /* = 2 × 16px = 32px */
.content { font-size: 1rem; }   /* = 1 × 16px = 16px */
```
- **1rem = html 元素的 font-size**
- 页面全局统一基准，改 html 一处全变
- 响应式布局主流方案：`@media` 改 html 字体大小，全页面所有 rem 自动缩放

### 对比总结
| 单位 | 参照物 | 特点 |
|------|--------|------|
| `px` | 无（绝对） | 固定不变，好算 |
| `em` | **当前元素**字体 | 嵌套会叠加，容易算晕 |
| `rem` | **根元素**字体 | 全局统一，不会叠加，推荐 |