require 'formula'

# Use a mirror because of:
# http://lists.cairographics.org/archives/cairo/2012-September/023454.html

class CairoQuartz < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.12.16.tar.xz'
  mirror 'https://downloads.sourceforge.net/project/machomebrew/mirror/cairo-1.12.16.tar.xz'
  sha256 '2505959eb3f1de3e1841023b61585bfd35684b9733c7b6a3643f4f4cbde6d846'

  keg_only :provided_pre_mountain_lion

  env :std if build.universal?

  depends_on 'pkg-config' => :build
  depends_on 'xz'=> :build

  depends_on :libpng
  depends_on 'pixman'
  depends_on 'glib'
  depends_on 'freetype'
  depends_on 'fontconfig'

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-x
      --enable-ft=yes
      --enable-fc=yes
      --enable-xlib=no
    ]
    
    args << '--enable-xcb=no' if MacOS.version == :leopard

    system "./configure", *args
    system "make install"
  end
end
