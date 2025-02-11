package rpc

import (
	"google.golang.org/protobuf/reflect/protoreflect"
)

type App struct{}

type Message struct {
	text string
}

func (m Message) ProtoReflect() protoreflect.Message {
	panic("implement me")
}
