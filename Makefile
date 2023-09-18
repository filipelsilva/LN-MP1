.PHONY: all

all:
	./run.sh

.PHONY: fst
fst:
	mkdir -p compiled
	for i in sources/*.txt tests/*.txt; do \
		echo "Compiling: $$i" ; \
		fstcompile --isymbols=syms.txt --osymbols=syms.txt $$i | fstarcsort > compiled/$$(basename $$i ".txt").fst ; \
	done

.PHONY: pdf
pdf:
	mkdir -p images
	for i in compiled/*.fst; do \
		echo "Creating image: images/$$(basename $$i '.fst').pdf" ; \
		fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $$i | dot -Tpdf > images/$$(basename $$i '.fst').pdf ; \
	done

.PHONY: test
test:
	for w in compiled/t-$(target)-*.fst; do \
		fstcompose $$w compiled/$(target).fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort > compiled/$$(basename $$w ".fst")-out.fst ; \
	done
	for i in compiled/t-$(target)-*-out.fst; do \
		echo "Creating image: images/$$(basename $$i '.fst').pdf" ; \
		fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $$i | dot -Tpdf > images/$$(basename $$i '.fst').pdf ; \
	done

.PHONY: clean
clean:
	rm -rf compiled images
