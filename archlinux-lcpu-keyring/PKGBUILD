# Maintainer: Zhou Qiankang <wszqkzqk@qq.com>

pkgname='archlinux-lcpu-keyring'
pkgver=20240906
pkgrel=1
pkgdesc="Arch Linux group of LCPU's PGP keyring"
arch=('any')
url='https://github.com/lcpu-club'
license=('GPL-3.0-or-later')
depends=("pacman" "archlinux-keyring")
install="archlinux-lcpu-keyring.install"
source=("Makefile"
        "master-keyids"
        "packager-keyids"
        "packager-revoked-keyids"
        "update-keys")
sha512sums=('b7df2aa75ab653bc608b726b600186b0cf62a3de9af0439dae0d3180fa215c1f2ab8ee0868e386bbdccec10f4b7d1bfa4b803ea06a35d3afbc3728a1cc960c7d'
            '49686aa36085aa21dbb5199e17ade2390307c1b88ddaceb04135e20b3c4868d1aa879225be501b28980b1479a1aee7316466aa4211c40d01ac883d13bd05326c'
            'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'
            'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'
            'ae31051fd88e2035f1250656ba73baf66a2d25088f536bd7163d4d088b39b20738743dd169473ad94141d2767bd83fc6ef6af1d248a20a3d7b42e2a441f56ee5')

pkgver() {
  make version
}

build() {
  ./update-keys
}

package() {
  make PREFIX=/usr "DESTDIR=$pkgdir" install
}
