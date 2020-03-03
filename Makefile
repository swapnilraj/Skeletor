outfile 	?= output.pdf
build_dir 	:= .build
meta_dir 	:= ./meta
infiles 	:= ./sections
pandoc_flags    := --number-sections -V fontsize=12pt

default: to_pdf

to_latex:
	mkdir -p $(build_dir)/latex
	touch $(build_dir)/include.tex
	# printf '\\documentclass[meta/main.tex]\n' > $(build_dir)/include.tex
	printf '\\begin{document}\n' >> $(build_dir)/include.tex
	$(foreach f, $(wildcard $(infiles)/*),\
		pandoc \
			--template=$(meta_dir)/section_template.tex\
			$(f) -o $(build_dir)/latex/$(shell basename $(f)).tex;\
		printf '\\subfile{$(build_dir)/latex/$(shell basename $(f))}\n' >> $(build_dir)/include.tex;\
	)
	printf '\\end{document}\n' >> $(build_dir)/include.tex

to_pdf: to_latex
	pandoc $(meta_dir)/main.tex $(pandoc_flags) -o $(outfile)

clean:
	-rm -r $(build_dir)
	-rm $(outfile)
