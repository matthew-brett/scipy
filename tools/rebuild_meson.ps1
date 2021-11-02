ninja -j 128 -C build
cd build
meson install
cd ..
. tools\post_meson.ps1 build\Lib\site-packages
