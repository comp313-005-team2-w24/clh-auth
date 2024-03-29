.PHONY: build protoc

run:
	go run ./cmd/main.go

build:
	CGO_ENABLED=0 go build -ldflags '-extldflags "-static"' -o bin/clh-auth cmd/main.go

run:
	./bin/clh-auth

cleanup:
	rm -rf ./internal/pb/
	rm -rf ./bin

PROTO_DIR=./api/proto
PROTO_OUT_DIR=./internal/pb

protoc:
	mkdir -p ./internal/pb
	protoc --go_out=$(PROTO_OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(PROTO_OUT_DIR) \
		--go-grpc_opt=paths=source_relative \
		-I=$(PROTO_DIR) $(PROTO_DIR)/auth/*.proto --experimental_allow_proto3_optional
