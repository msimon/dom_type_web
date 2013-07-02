.PHONY: all sass clean

all:
	@ocamlbuild dom_typ.otarget
	@cp _build/dom_typ.js public

sass:
	@compass compile ./css
	@cp -r ./css/css/ ./public

clean:
	rm -rf _build
