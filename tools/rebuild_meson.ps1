# Rebuild meson script
if ($args.count -eq 0) {
    echo "Specify build directory"
    exit 1
}
$build_path = Resolve-Path $args[0]
ninja -j 128 -C $build_path
cd $build_path
meson install
cd ..
. tools\post_meson.ps1 $build_path
