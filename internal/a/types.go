//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock_$GOFILE
package a

type a interface {
	A()
}

func x(a1 a) {
	a1.A()
}
