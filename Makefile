CCFLAGS ?= -fno-objc-arc -Wno-deprecated-declarations
.PHONY: clean run
pickdate: pickdate.m
	$(CC) $^ -framework Cocoa -o $@ $(CCFLAGS)
run: pickdate
	./pickdate
clean:
	rm pickdate
