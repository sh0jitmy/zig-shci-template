ZIG ?= zig
TARGET ?= native
OPTIMIZE ?= Debug

.PHONY: all build run test clean

all: build

build:
	$(ZIG) build -Doptimize=$(OPTIMIZE) -Dtarget=$(TARGET)

run:
	$(ZIG) build run

test:
	$(ZIG) build test

clean:
	$(ZIG) build clean
