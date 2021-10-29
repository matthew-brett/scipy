# Post-meson install script
if ($args.count -eq 0) {
    echo "Specify site-packages containing scipy directory"
    exit 1
}
$out_path = Resolve-Path $args[0]
$scipy_path = "$out_path\scipy"
if (!(Test-Path -path $scipy_path)) {
    echo "$out_path does not contain a scipy directory"
    exit 2
}
# Make .libs directory if necessary.
$libs_path = "$scipy_path\.libs"
if (!(Test-Path -path $libs_path)) {
    mkdir $libs_path
}
# Copy openblas dlls to .libs directory
$ob_path = (pkg-config --variable libdir openblas) -replace "lib", "bin"
cp $ob_path/*.dll $libs_path
# Write _distributor_init.py to scipy dir to load .libs DLLs.
& python tools\openblas_support.py --write-init $scipy_path
# Set PYTHONPATH
$env:PYTHONPATH="$env:PYTHONPATH;$out_path"

echo "Configured output Scipy directory"
