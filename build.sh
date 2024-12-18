#!/bin/bash

set -e

IPHONEOS_CLANG=$(xcrun --sdk iphoneos -f clang)

IPHONEOS_SDK_DIR=$(xcrun --sdk iphoneos --show-sdk-path)

$IPHONEOS_CLANG -dynamiclib \
    -x objective-c \
    -target arm64-apple-ios13.1 \
    -isysroot $IPHONEOS_SDK_DIR \
    -framework Foundation \
    -framework UIKit \
    -o LuckySpeeder.dylib LuckySpeeder.m \
    -Ofast \
    -flto

MACOSX_CLANG=$(xcrun --sdk macosx -f clang)

MACOSX_SDK_DIR=$(xcrun --sdk macosx --show-sdk-path)

$MACOSX_CLANG -dynamiclib \
    -x objective-c \
    -target arm64-apple-ios13.1-macabi \
    -isysroot $MACOSX_SDK_DIR \
    -isystem $MACOSX_SDK_DIR/System/iOSSupport/usr/include \
    -iframework $MACOSX_SDK_DIR/System/iOSSupport/System/Library/Frameworks \
    -framework Foundation \
    -framework UIKit \
    -o LuckySpeeder_macos.dylib LuckySpeeder.m \
    -Ofast \
    -flto
