//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock_$GOFILE
package b

type b interface {
	B()
}
