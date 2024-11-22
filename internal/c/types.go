//go:generate mockgen -source=$GOFILE -package=$GOPACKAGE_test --destination=mock_$GOFILE
package c

type c interface {
	C()
}
