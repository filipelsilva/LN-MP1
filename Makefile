.PHONY: all
all:
	./run.sh

.PHONY: test
test:
	./test.sh $(target)

.PHONY: test-all
test-all:
	./test.sh mmm2mm
	./test.sh mix2numerical
	./test.sh pt2en
	./test.sh en2pt
	./test.sh day
	./test.sh month
	./test.sh year
	./test.sh datenum2text
	./test.sh mix2text
	./test.sh date2text

.PHONY: test-extensive
test-extensive:
	./test-extensive.sh $(target)

.PHONY: test-extensive-all
test-extensive-all:
	./test-extensive.sh mmm2mm
	./test-extensive.sh mix2numerical
	./test-extensive.sh pt2en
	./test-extensive.sh en2pt
	./test-extensive.sh day
	./test-extensive.sh month
	./test-extensive.sh year
	./test-extensive.sh datenum2text
	./test-extensive.sh mix2text
	./test-extensive.sh date2text

.PHONY: pdf
pdf:
	pandoc -s -V papersize:a4 report.md -o report.pdf

.PHONY: clean
clean:
	rm -rf compiled images report.pdf
