# Post-meson install script
if ($args.count -eq 0) {
    echo "Specify build directory"
    exit 1
}
$build_path = Resolve-Path $args[0]
$site_path = "$build_path\Lib\site-packages"
# Set PYTHONPATH
$env:PYTHONPATH="$site_path"
