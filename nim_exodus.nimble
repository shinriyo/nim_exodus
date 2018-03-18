# Package

version = "0.0.1"
author = "Shinsuke Sugita (@shinriyo)"
description = "Template generator for gester"
license = "MIT"
bin= @["shinriyo"]
srcDir = "src"
skipDirs = @["sample"]

# Dependencies

requires "nim >= 0.15.2", "jester"
