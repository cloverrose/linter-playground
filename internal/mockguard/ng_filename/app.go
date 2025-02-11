//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE --destination=mock_test.go

package ng_filename

type c interface {
	C()
}
