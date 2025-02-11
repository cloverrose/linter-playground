package rpc

import (
	"context"

	"connectrpc.com/connect"
	"github.com/bufbuild/protovalidate-go"
)

func (a *App) OK(ctx context.Context, req *connect.Request[Message]) (*connect.Response[Message], error) {
	if err := protovalidate.Validate(req.Msg); err != nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, err)
	}
	return connect.NewResponse(&Message{"OK"}), nil
}
