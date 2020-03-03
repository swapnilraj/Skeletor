outfile 	?= output.pdf
build_dir 	:= .build
meta_dir 	:= ./meta
infiles 	:= ./sections

default: to_pdf

to_latex:
	mkdir -p $(build_dir)/latex
	touch $(build_dir)/include.tex
	#echo "\documentclass[meta/main.tex]" > $(build_dir)/include.tex
	echo "\begin{document}" >> $(build_dir)/include.tex
	$(foreach f, $(wildcard $(infiles)/*),\
		pandoc \
			--template=$(meta_dir)/section_template.tex\
			$(f) -o $(build_dir)/latex/$(shell basename $(f)).tex;\
		echo "\subfile{$(build_dir)/latex/$(shell basename $(f))}" >> $(build_dir)/include.tex;\
	)
	echo "\end{document}" >> $(build_dir)/include.tex

to_pdf: to_latex
	pandoc $(meta_dir)/main.tex -o $(outfile)

clean:
	-rm -r $(build_dir)
	-rm $(outfile)
