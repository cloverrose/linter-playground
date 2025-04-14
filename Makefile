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

# update updates dependencies.
.PHONY: update
update:
	make go/update
	make aqua/update

# aqua/install installs aqua dependencies.
.PHONY: aqua/install
aqua/install:
	aqua install

# aqua/update-checksum updates the checksums for the aqua dependencies.
.PHONY: aqua/update-checksum
aqua/update-checksum:
	aqua update-checksum --deep --prune

# aqua/update updates aqua dependencies.
.PHONY: aqua/update
aqua/update:
	aqua update-aqua
	aqua update
	aqua update-checksum --deep --prune
	aqua install

# aqua/reset removes all the aqua dependencies.
.PHONY: aqua/reset
aqua/reset:
	aqua rm -all

# lint runs the linters.
.PHONY: lint
lint: bin/custom-golangci-lint
	go version
	golangci-lint version
	$(GOLINTCMD) version
	$(GOLINTCMD) run $(args) --config=./.golangci.yaml ./...

# fmt formats the files.
.PHONY: fmt
fmt:
	@find . -iname "*.go" -not -path "./vendor/**" | xargs gofmt -s -w
	gofumpt -w -extra .
	@# gci's option should match with .golangci.yaml
	gci write . --skip-generated --skip-vendor --custom-order -s standard -s default -s 'prefix(github.com/cloverrose)'

# tidy updates the go.mod and go.sum files.
.PHONY: tidy
tidy:
	go mod tidy -v

# tidy updates go dependencies.
.PHONY: go/update
go/update:
	go get -u all
	go mod tidy -v

.PHONY: go/gen
go/gen:
	go mod tidy -v
	make fmt
	go mod download
	go generate ./...
