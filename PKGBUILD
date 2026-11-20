# Maintainer: sukkergris
pkgname=hifi-tui-git
pkgver=r0.0000000
pkgrel=1
pkgdesc='Local music player for the terminal: fzf + mpv'
arch=(any)
url='https://github.com/sukkergris/hifi-tui'
license=(MIT)
depends=(bash fzf mpv jq socat curl)
makedepends=(git)
provides=(hifi-tui)
conflicts=(hifi-tui)
source=("git+$url.git")
sha256sums=(SKIP)

pkgver() {
    cd hifi-tui
    printf 'r%s.%s' "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
    cd hifi-tui
    install -Dm755 bin/hifi "$pkgdir/usr/bin/hifi"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
}
