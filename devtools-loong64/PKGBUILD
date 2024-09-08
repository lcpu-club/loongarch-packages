# Maintainer: wszqkzqk <wszqkzqk@qq.com>

_pkgver=1.2.1
_patchver=7
pkgname=devtools-loong64
pkgver=${_pkgver}.patch${_patchver}
pkgrel=4
pkgdesc='Tools for Arch Linux LoongArch package maintainers'
arch=('loong64' 'x86_64' 'riscv64' 'aarch64')
license=('GPL-3.0-or-later')
url='https://gitlab.archlinux.org/archlinux/devtools'
depends=("devtools>=1:${_pkgver}")
source=(makepkg-loong64.patch
        pacman-extra-loong64.patch
        pacman-extra-testing-loong64.patch
        pacman-extra-staging-loong64.patch
        sogrep-loong64.patch
        valid-repos-loong64.sh)
sha256sums=('bd7509dc15a0c49a801d009733ec8c2df69ed5cb6e30aecdaa24c9f9920d5fc4'
            '9f59291ef061b943304b876ebdcd0c1f55b1681168f0984d2b8ca7e9200ee496'
            '598cf18e7edee2446c3b4661960fd50cbc812b1f28bc4e438efb620ffed518df'
            'edcee3ed42642f0794a772b6f13b1f8bfb327c5d2011ef82466886769ece2a3a'
            '1a508d14b8883a119caab7e60ce41893964bbc8f7c34ee0871a34b1aa9b613d5'
            '820cb7964fd724b88b3a4df87f3ca86b53c3d3e5c314024599dfc50afdcbc7a0')

if [[ ! "$CARCH" =~ loong ]]; then
  depends+=(qemu-user-static)
  source+=(z-qemu-loong64-static-for-archpkg.conf)
  sha256sums+=('0fa4957e6a2097a288036d18953969ff765912518f5b6a01f983a3d2f7f6a8e1')
fi

package() {
  install -Dm644 valid-repos-loong64.sh -t "$pkgdir"/usr/share/devtools/lib
  patch /usr/bin/sogrep -i sogrep-loong64.patch -o sogrep-loong64
  install -Dm755 sogrep-loong64 -t "$pkgdir"/usr/bin/

  ln -s /usr/bin/archbuild "$pkgdir"/usr/bin/extra-loong64-build
  ln -s /usr/bin/archbuild "$pkgdir"/usr/bin/extra-testing-loong64-build
  ln -s /usr/bin/archbuild "$pkgdir"/usr/bin/extra-staging-loong64-build

  patch /usr/share/devtools/makepkg.conf.d/x86_64.conf -i makepkg-loong64.patch -o loong64.conf
  install -Dm644 loong64.conf -t "$pkgdir"/usr/share/devtools/makepkg.conf.d
  patch /usr/share/devtools/pacman.conf.d/extra.conf -i pacman-extra-loong64.patch -o extra-loong64.conf
  install -Dm644 extra-loong64.conf -t "$pkgdir"/usr/share/devtools/pacman.conf.d
  patch /usr/share/devtools/pacman.conf.d/extra.conf -i pacman-extra-testing-loong64.patch -o extra-testing-loong64.conf
  install -Dm644 extra-testing-loong64.conf -t "$pkgdir"/usr/share/devtools/pacman.conf.d
  patch /usr/share/devtools/pacman.conf.d/extra.conf -i pacman-extra-staging-loong64.patch -o extra-staging-loong64.conf
  install -Dm644 extra-staging-loong64.conf -t "$pkgdir"/usr/share/devtools/pacman.conf.d

  install -dm755 "$pkgdir"/usr/share/devtools/setarch-aliases.d
  if [[ ! "$CARCH" =~ loong ]]; then
    echo "$CARCH" > "$pkgdir"/usr/share/devtools/setarch-aliases.d/loong64
    # qemu-user-static-binfmt with C flag
    install -Dm644 z-qemu-loong64-static-for-archpkg.conf -t "$pkgdir"/usr/lib/binfmt.d/
  else # loongarch64 <--> loong64
    echo "$(uname -m)" > "$pkgdir"/usr/share/devtools/setarch-aliases.d/loong64
  fi
}
