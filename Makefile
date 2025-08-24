# LaTeX文档编译Makefile

# 主文档名称
MAIN = main

# LaTeX编译器
LATEX = xelatex

# BibTeX编译器
BIBTEX = bibtex

# 输出目录
OUTDIR = build

# 创建输出目录
$(OUTDIR):
	mkdir $(OUTDIR)

# 编译PDF
pdf: $(OUTDIR)
	$(LATEX) -output-directory=$(OUTDIR) $(MAIN).tex
	$(LATEX) -output-directory=$(OUTDIR) $(MAIN).tex

# 完整编译（包含参考文献）
full: $(OUTDIR)
	$(LATEX) -output-directory=$(OUTDIR) $(MAIN).tex
	$(BIBTEX) $(OUTDIR)/$(MAIN)
	$(LATEX) -output-directory=$(OUTDIR) $(MAIN).tex
	$(LATEX) -output-directory=$(OUTDIR) $(MAIN).tex

# 清理临时文件
clean:
	rm -rf $(OUTDIR)

# 清理所有生成文件
distclean: clean
	rm -f *.pdf

# 查看PDF
view: pdf
	start $(OUTDIR)/$(MAIN).pdf

.PHONY: pdf full clean distclean view