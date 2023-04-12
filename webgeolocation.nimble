# Package

version       = "1.0.0"
author        = "Mark Leyva"
description   = "Bindings to the Webgeolocation Web API"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.12"

task demo, "Demo":
    exec "nim js --mm:oc --out:tests/geotest.js -d:release --opt:size tests/geotest.nim"
task docs, "Docs":
    exec "nim doc --backend:js --out:htmldocs/ src/webgeolocation.nim"
