.PHONY: all
all:
	./run.sh

.PHONY: test
test:
	./test.sh $(target)

.PHONY: clean
clean:
	rm -rf compiled images
