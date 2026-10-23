# 图源（一般不用看）

正文里的 5 张示意图，都是这里的 HTML 用 Chrome 无头截图出来的。
想改图上的文字或配色，改对应 `.html` 后重新截一次即可：

```bash
cd _src
./shoot.sh fig1-architecture 790     # 生成 ../images/fig1-architecture.png
```

| 文件 | 对应图 |
|---|---|
| `fig1-architecture.html` | 全链路架构（README） |
| `fig2-directory.html` | 目录结构（02） |
| `fig3-ports.html` | 三段端口（01、04） |
| `fig4-deploy-order.html` | 部署顺序（03） |
| `fig5-fault-tree.html` | 故障树（05） |
| `style.css` | 统一配色与排版 |

需要 macOS + Google Chrome。只想读文档的话，整个 `_src/` 目录可以忽略。
