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

.PHONY: clean
clean:
	rm -rf compiled images
