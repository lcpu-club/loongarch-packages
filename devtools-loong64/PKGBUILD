# Maintainer: wszqkzqk <wszqkzqk@qq.com>

_pkgver=1.4.0
_patchver=1
pkgname=devtools-loong64
pkgver=${_pkgver}.patch${_patchver}
pkgrel=2
pkgdesc='Tools for Arch Linux LoongArch package maintainers'
arch=('loong64' 'x86_64' 'riscv64' 'aarch64')
license=('GPL-3.0-or-later')
url='https://gitlab.archlinux.org/archlinux/devtools'
depends=("bash"
         "coreutils"
         "devtools>=1:${_pkgver}"
         "grep"
         "git"
         "patch"
         "pyalpm"
         "python"
         "python-gobject"
         "sed")
source=(makepkg-loong64.patch
        fortran-loong64.patch
        pacman-extra-loong64.patch
        pacman-extra-testing-loong64.patch
        pacman-extra-staging-loong64.patch
        sogrep-loong64.patch
        valid-repos-loong64.sh
        # Extra tools for loong64 maintainers
        export-loong64-patches
        get-loong64-pkg
        # Following items are unused in loong64
        mirrorlist-loong64
        z-qemu-loong64-static-for-archpkg.conf)
sha256sums=('7b9efdecfe9b770cedf9f8a7039aad31842454167caddb63315ec58949edaf24'
            'eece7a2beedfd9bf367d5930871296223b8f7ec09541d20719e9f52b61b88254'
            '16bae6549b594284d1e08caa831f67f5aa251447449a40c846ad9ad4701ca252'
            '0bb9058a722971752ec714707eecca6af32f212069bbd2d138bbd4414eaf00c0'
            '4866d3086f6846c070d2aa2add4258baf7111b1fe3d249cdc6a0580fa7e8cc85'
            '3e048911fb330cd92d88c330c91232d8e271c892aa239c82d979ffedc20c215c'
            '820cb7964fd724b88b3a4df87f3ca86b53c3d3e5c314024599dfc50afdcbc7a0'
            'a33135cf0adf39bc93076928eade0a9b2efb24d8bdc692d61bd1a00552c74d7a'
            '0bd5e25fe219fd913e820e49f1de170089d641dafe7dc4167601d10efaaaab54'
            '9510b27d5f3f360bc57d6911d061ac3a5cca24a824ed2c3f215da80ac05e528e'
            '0fa4957e6a2097a288036d18953969ff765912518f5b6a01f983a3d2f7f6a8e1')

if [[ ! "$CARCH" =~ loong ]]; then
  depends+=(qemu-user-static)
  provides+=(pacman-mirrorlist-loong64)
  backup+=(etc/pacman.d/mirrorlist-loong64)
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

  install -dm755 "$pkgdir"/usr/share/devtools/makepkg.conf.d/loong64.conf.d

  for conf in rust.conf; do
    ln -s '../conf.d/'$conf "$pkgdir"/usr/share/devtools/makepkg.conf.d/loong64.conf.d/$conf
  done
  patch /usr/share/devtools/makepkg.conf.d/conf.d/fortran.conf -i fortran-loong64.patch -o fortran-loong64.conf
  install -Dm644 fortran-loong64.conf "$pkgdir"/usr/share/devtools/makepkg.conf.d/loong64.conf.d/fortran.conf

  install -Dm755 "${srcdir}/get-loong64-pkg" -t "$pkgdir"/usr/bin/
  install -Dm755 "${srcdir}/export-loong64-patches" -t "$pkgdir"/usr/bin/
}
