//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock_test.go

package ok

type a interface {
	A()
}

func x(a1 a) {
	a1.A()
}
