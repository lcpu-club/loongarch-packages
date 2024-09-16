# Maintainer: wszqkzqk <wszqkzqk@qq.com>

_pkgver=1.2.1
_patchver=9
pkgname=devtools-loong64
pkgver=${_pkgver}.patch${_patchver}
pkgrel=1
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
            '2356999e91739f9887057dbd1a9ee9cefda4971c85a91793a81f20922877e3b8'
            '63ad51bbb598673fdae9bba2cb483f996894262996543964951fb87b610586cd'
            '6b545a5579957cd4fef8303a7fa27e3f754d3bd1b7fe47c3a7bb049ebf917388'
            '3e048911fb330cd92d88c330c91232d8e271c892aa239c82d979ffedc20c215c'
            '820cb7964fd724b88b3a4df87f3ca86b53c3d3e5c314024599dfc50afdcbc7a0')

if [[ ! "$CARCH" =~ loong ]]; then
  depends+=(qemu-user-static)
  provides+=(pacman-mirrorlist-loong64)
  backup+=(etc/pacman.d/mirrorlist-loong64)
  source+=(mirrorlist-loong64
           z-qemu-loong64-static-for-archpkg.conf)
  sha256sums+=('b0d95a78ea22f28dc9d0c450e7c7f376a8772e15b7140be034d4c0538a95f63c'
               '0fa4957e6a2097a288036d18953969ff765912518f5b6a01f983a3d2f7f6a8e1')
fi

package() {
  install -Dm644 valid-repos-loong64.sh -t "$pkgdir"/usr/share/devtools/lib
  patch /usr/bin/sogrep -i sogrep-loong64.patch -o sogrep-loong64
  install -Dm755 sogrep-loong64 -t "$pkgdir"/usr/bin/

  patch /usr/share/devtools/makepkg.conf.d/x86_64.conf -i makepkg-loong64.patch -o loong64.conf
  install -Dm644 loong64.conf -t "$pkgdir"/usr/share/devtools/makepkg.conf.d

  for repo in extra extra-testing extra-staging; do
    ln -s /usr/bin/archbuild "$pkgdir"/usr/bin/$repo-loong64-build
    patch /usr/share/devtools/pacman.conf.d/$repo.conf -i pacman-$repo-loong64.patch -o $repo-loong64.conf
    install -Dm644 $repo-loong64.conf -t "$pkgdir"/usr/share/devtools/pacman.conf.d
  done

  install -dm755 "$pkgdir"/usr/share/devtools/setarch-aliases.d
  if [[ ! "$CARCH" =~ loong ]]; then
    echo "$CARCH" > "$pkgdir"/usr/share/devtools/setarch-aliases.d/loong64
    install -Dm644 mirrorlist-loong64 -t "$pkgdir"/etc/pacman.d
    # qemu-user-static-binfmt with C flag
    install -Dm644 z-qemu-loong64-static-for-archpkg.conf -t "$pkgdir"/usr/lib/binfmt.d/
  else # loongarch64 <--> loong64
    echo "$(uname -m)" > "$pkgdir"/usr/share/devtools/setarch-aliases.d/loong64
  fi
}
