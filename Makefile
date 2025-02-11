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

# bin/custom-golangci-lint builds the custom golangci-lint binary.
bin/custom-golangci-lint: .custom-gcl.yml
	@PATH=$(dir $(shell aqua which go)):$(PATH) golangci-lint custom -v

.PHONY: lint
lint: bin/custom-golangci-lint
	go version
	golangci-lint version
	$(GOLINTCMD) version
	$(GOLINTCMD) run $(args) --config ./.golangci.yml ./...

.PHONY: go/gen
go/gen:
	go mod tidy -v
	make go/fmt
	go mod download
	go generate ./...

# go/fmt formats the files.
.PHONY: go/fmt
go/fmt:
	@find . -iname "*.go" -not -path "./vendor/**" | xargs gofmt -s -w
	gofumpt -w -extra .
	@# gci's option should match with .golangci.yaml
	gci write . --skip-generated --skip-vendor --custom-order -s standard -s default -s 'prefix(github.com/cloverrose)'

.PHONY: aqua/install
aqua/install:
	aqua install

.PHONY: aqua/update-checksum
aqua/update-checksum:
	aqua update-checksum --deep --prune

.PHONY: aqua/reset
aqua/reset:
	aqua rm -all