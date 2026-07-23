# RAG（Retrieval-Augmented Generation）检索增强生成

- **RAG**（Retrieval-Augmented Generation）= 检索增强生成
- **Embedding** = 向量化
- **Chunking** = 分块
- **LLM**（Large Language Model）= 大语言模型

## 为什么需要 RAG

LLM本质是不断预测下一个概率最大的文字，所以会出现幻觉
RAG 就是为了**降低大模型幻觉**。

## 为什么用向量数据库

传统数据库只能做**关键词匹配**。

向量数据库存的是**向量**（浮点型数据），通过**余弦相似度**等数学公式量化语义相似性，能处理同义词、多义词、语境差异。

> 例子：搜"腾讯的技术创新"，向量数据库能匹配到"微信支付的研发进展"（语义相近但无关键词），传统数据库则匹配不到。

## RAG 流程

```
构建：文档 → 切块 → Embedding → 向量库
查询：问题 → Embedding → 向量检索 → 拼 Prompt → LLM → 回答
```
