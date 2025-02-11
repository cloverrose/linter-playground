//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock.go

package ng_content

type b interface {
	B()
}
