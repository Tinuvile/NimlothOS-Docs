# 操作系统实现教程 LaTeX 模板

这是一个用于编写操作系统实现教程的 LaTeX 模板，参考了 rCore 教程的结构，采用渐进式的方法从简单到复杂逐步构建操作系统。

## 项目结构

```
├── main.tex                    # 主文档文件
├── build.ps1                   # PowerShell 编译脚本
├── Makefile                    # Make 编译脚本（需要安装 make 工具）
├── chapters/                   # 章节目录
│   ├── preface.tex            # 前言
│   ├── ch01-introduction.tex   # 第1章：操作系统概述
│   ├── ch02-environment.tex    # 第2章：开发环境搭建
│   ├── ch03-bare-metal.tex     # 第3章：裸机程序
│   ├── ch04-memory-layout.tex  # 第4章：内存布局与链接
│   ├── ch05-batch-system.tex   # 第5章：批处理系统
│   ├── ch06-privilege-levels.tex # 第6章：特权级与异常处理
│   ├── ch07-multiprogramming.tex # 第7章：多道程序
│   ├── ch08-cooperative-scheduling.tex # 第8章：协作式调度
│   ├── ch09-preemptive-scheduling.tex # 第9章：抢占式调度
│   ├── ch10-process-management.tex # 第10章：进程管理
│   ├── ch11-address-space.tex  # 第11章：地址空间
│   ├── ch12-virtual-memory.tex # 第12章：虚拟内存管理
│   ├── ch13-ipc.tex           # 第13章：进程间通信
│   ├── ch14-synchronization.tex # 第14章：同步与互斥
│   ├── ch15-filesystem.tex     # 第15章：文件系统
│   ├── ch16-io-management.tex  # 第16章：I/O管理
│   ├── appendix-a-tools.tex    # 附录A：开发工具详解
│   └── appendix-b-references.tex # 附录B：参考资料
└── build/                      # 编译输出目录（自动创建）
```

## 功能特性

- **中文支持**：使用 ctex 包，完美支持中文排版
- **代码高亮**：内置 Rust 语言支持，可扩展其他语言
- **现代化排版**：优雅的页面布局和字体设置
- **完整目录**：自动生成目录和超链接
- **模块化结构**：每章独立文件，便于管理和协作

## 编译方法

### 方法一：开发模式（推荐）- 自动监控文件变化

```powershell
# 快速启动开发模式（自动监控 .tex 文件变化并重新编译）
.\dev.ps1

# 使用完整编译模式（包含参考文献）
.\dev.ps1 -Full

# 启动前清理构建文件
.\dev.ps1 -Clean

# 自定义防抖延迟（默认2秒）
.\dev.ps1 -Debounce 3
```

**开发模式特性**：

- 🚀 自动监控所有 `.tex` 文件变化
- ⚡ 智能防抖，避免频繁编译
- 🎯 实时反馈编译状态
- 🛑 按 `Ctrl+C` 停止监控

### 方法二：手动编译

```powershell
# 基本编译
.\build.ps1 pdf

# 完整编译（包含参考文献）
.\build.ps1 full

# 编译并查看PDF
.\build.ps1 view

# 清理临时文件
.\build.ps1 clean
```

### 方法二：使用 Make（需要安装 make 工具）

```bash
# 基本编译
make pdf

# 完整编译
make full

# 查看PDF
make view

# 清理文件
make clean
```

## 环境要求

### 必需软件

1. **LaTeX 发行版**（选择其一）：

   - [TeX Live](https://www.tug.org/texlive/)（推荐）
   - [MiKTeX](https://miktex.org/)

2. **编译器**：
   - XeLaTeX（用于中文支持）

### 可选工具

- **Make 工具**（如果使用 Makefile）：
  - Windows: 通过 [Git for Windows](https://git-scm.com/download/win) 或 [Chocolatey](https://chocolatey.org/) 安装
  - macOS: 通过 Xcode Command Line Tools
  - Linux: 通常已预装

## 使用说明

1. **修改文档信息**：

   - 编辑 `main.tex` 中的 `\title`、`\author` 等信息

2. **添加内容**：

   - 在对应的章节文件中添加具体内容
   - 使用 `\section`、`\subsection` 等命令组织结构

3. **插入代码**：

   ```latex
   \begin{lstlisting}[language=Rust, caption=代码示例]
   fn main() {
       println!("Hello, World!");
   }
   \end{lstlisting}
   ```

4. **插入图片**：

   ```latex
   \begin{figure}[H]
       \centering
       \includegraphics[width=0.8\textwidth]{images/example.png}
       \caption{图片说明}
       \label{fig:example}
   \end{figure}
   ```

5. **添加引用**：
   ```latex
   如图 \ref{fig:example} 所示...
   ```

## 自定义配置

### 添加新的编程语言支持

在 `main.tex` 中添加语言定义：

```latex
\lstdefinelanguage{YourLanguage}{
    keywords={keyword1, keyword2, ...},
    keywordstyle=\color{blue}\bfseries,
    % 其他配置...
}
```

### 修改页面布局

调整 `main.tex` 中的 geometry 包设置：

```latex
\usepackage[margin=2.5cm]{geometry}  % 修改页边距
```

### 更改字体

修改 ctex 包的字体设置或添加 fontspec 配置。

## PDF 导航功能

生成的 PDF 包含完整的导航功能：

1. **目录跳转**：点击目录中的章节标题可直接跳转到对应页面
2. **书签导航**：PDF 阅读器左侧会显示书签面板，可快速导航
3. **超链接**：文档内的交叉引用都是可点击的链接
4. **返回功能**：大多数 PDF 阅读器支持前进/后退按钮

**使用建议**：

- 使用 Adobe Acrobat Reader、Foxit Reader 或现代浏览器打开 PDF
- 确保 PDF 阅读器的书签面板已开启
- 在移动设备上，通常可以通过点击屏幕边缘或菜单访问书签

## 常见问题

1. **编译错误**：确保安装了完整的 LaTeX 发行版
2. **中文显示问题**：确保使用 XeLaTeX 编译器
3. **代码高亮问题**：检查 listings 包的语言定义
4. **图片不显示**：确保图片路径正确且格式支持
5. **目录无法跳转**：确保使用支持超链接的 PDF 阅读器，避免使用过旧的阅读器

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个模板。

## 许可证

本模板采用 MIT 许可证，可自由使用和修改。
