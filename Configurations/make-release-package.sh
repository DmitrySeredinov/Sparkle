#!/bin/bash
set -e

if [ "$ACTION" = "" ] ; then
    rm -rf "$CONFIGURATION_BUILD_DIR/staging"
    rm -f "Sparkle-$CURRENT_PROJECT_VERSION.tar.bz2"

    mkdir -p "$CONFIGURATION_BUILD_DIR/staging"
    cp "$SRCROOT/CHANGELOG" "$SRCROOT/LICENSE" "$SRCROOT/Resources/SampleAppcast.xml" "$CONFIGURATION_BUILD_DIR/staging"
    cp -R "$SRCROOT/bin" "$CONFIGURATION_BUILD_DIR/staging"
    cp "$CONFIGURATION_BUILD_DIR/BinaryDelta" "$CONFIGURATION_BUILD_DIR/staging/bin"
    cp -R "$CONFIGURATION_BUILD_DIR/BinaryDelta.dSYM" "$CONFIGURATION_BUILD_DIR/staging/bin"
    cp -R "$CONFIGURATION_BUILD_DIR/Sparkle Test App.app" "$CONFIGURATION_BUILD_DIR/staging"
    cp -R "$CONFIGURATION_BUILD_DIR/Sparkle Test App.app.dSYM" "$CONFIGURATION_BUILD_DIR/staging"
    cp -R "$CONFIGURATION_BUILD_DIR/Sparkle.framework" "$CONFIGURATION_BUILD_DIR/staging"
    cp -R "$CONFIGURATION_BUILD_DIR/Sparkle.framework.dSYM" "$CONFIGURATION_BUILD_DIR/staging"

    cd "$CONFIGURATION_BUILD_DIR/staging"
    # Sorted file list groups similar files together, which improves tar compression
    find . \! -type d | rev | sort | rev | tar cjvf "../Sparkle-$CURRENT_PROJECT_VERSION.tar.bz2" --files-from=-
    rm -rf "$CONFIGURATION_BUILD_DIR/staging"
fi
