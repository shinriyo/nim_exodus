# Package

version = "0.0.1"
author = "Shinsuke Sugita (@shinriyo)"
description = "Template generator for gester"
license = "MIT"
srcDir = "src"
skipDirs = @["sample"]
bin = @["exodus"]
binDir = "bin"

# Dependencies

requires "nim >= 0.15.2", "jester"
