//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock_$GOFILE
package a

type a interface {
	A()
}
