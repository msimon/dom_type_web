.PHONY: all sass clean

all:
	@ocamlbuild dom_type.otarget
	@cp _build/dom_type.js public

sass:
	@compass compile ./css
	@cp -r ./css/css/ ./public

clean:
	rm -rf _build
