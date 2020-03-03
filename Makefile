output ?= output.pdf

in_sections := ./sections

default: to_pdf

to_latex:
	mkdir -p output/latex
	$(foreach f, $(wildcard $(in_sections)/*),\
		pandoc $(f) -o output/latex/$(shell basename $(f)).tex;\
	)

to_pdf: to_latex
	pandoc output/latex/* -o $(output)

clean:
	-rm -r output
	-rm $(output)
