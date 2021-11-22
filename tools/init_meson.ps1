# Init scipy build.
# $ucrt_tools = "C:\rtools40"
# Or:
$ucrt_tools = "C:\msys64"
# Compilers, and make tools.
$env:PATH = "$env:PATH;$ucrt_tools\ucrt64\bin;$ucrt_tools\usr\bin"
# In order to find OpenBLAS
$env:PKG_CONFIG_PATH = "c:\opt\openblas\if_32\64\lib\pkgconfig;"
