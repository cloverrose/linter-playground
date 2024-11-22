export

# Setup Go Variables
GOPATH := $(shell go env GOPATH)
GOBIN := $(PWD)/bin

# Invoke shell with new path to enable access to bin
PATH := $(GOBIN):$(PATH)
PATH := $(shell aqua root-dir)/bin:$(PATH)
SHELL := env "PATH=$(PATH)" bash

GOLINTCMD := ./bin/custom-golangci-lint

.PHONY: gen
gen:
	make aqua/update-checksum
	make go/gen

.PHONY: lint
lint:
	go version
	golangci-lint version
	golangci-lint custom -v
	$(GOLINTCMD) version
	$(GOLINTCMD) run $(args) --config ./.golangci.yml ./...

.PHONY: go/gen
go/gen:
	go mod tidy -v
	go mod vendor
	go generate ./...

.PHONY: aqua/install
aqua/install:
	aqua install

.PHONY: aqua/update-checksum
aqua/update-checksum:
	aqua update-checksum --deep --prune

.PHONY: aqua/reset
aqua/reset:
	aqua rm -all