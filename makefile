pdf:
	mkdir pdf

all: pdf tex

clean: tex-clean

dist-clean: tex-dist-clean

include tex/makefile
