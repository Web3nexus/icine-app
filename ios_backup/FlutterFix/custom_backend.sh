#!/bin/sh
# Custom Flutter backend script to skip embed_and_thin (for Xcode Beta)
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" thin
