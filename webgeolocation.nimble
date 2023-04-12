# Package

version       = "1.0.0"
author        = "Mark Leyva"
description   = "Bindings to the Webgeolocation Web API"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"

task demo, "Demo":
    exec "nim js --out:tests/geotest.js -d:release --opt:size tests/geotest.nim"
    exec "python3 -m http.server --directory tests/"
task docs, "Docs":
    exec "nim doc --backend:js --out:htmldocs/ src/webgeolocation.nim"
