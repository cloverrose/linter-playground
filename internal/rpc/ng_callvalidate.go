package rpc

import (
	"context"

	"connectrpc.com/connect"
)

func (a *App) NGCallValidate(ctx context.Context, req *connect.Request[Message]) (*connect.Response[Message], error) {
	return connect.NewResponse(&Message{"NG callvalidate"}), nil
}
