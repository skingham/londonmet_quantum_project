pdf:
	mkdir pdf

all: pdf tex

clean: tex-clean

include tex/makefile
