# Init scipy build.
$ucrt_tools = "C:\rtools40"
# Or:
# $ucrt_tools = "C:\msys64-ucrt"
# Compilers, and make tools.
$env:PATH = "$ucrt_tools\ucrt64\bin;$ucrt_tools\usr\bin;$env:PATH"
# In order to find OpenBLAS
$env:PKG_CONFIG_PATH = "c:\opt\openblas\if_32\64\lib\pkgconfig;"
