package rpc

import (
	"context"

	"connectrpc.com/connect"
)

func (a *App) NGConnectNew(ctx context.Context, req *connect.Request[Message]) (*connect.Response[Message], error) {
	return &connect.Response[Message]{Msg: &Message{"NG callvalidate"}}, nil
}
