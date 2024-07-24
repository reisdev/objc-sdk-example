#!/bin/bash

xcodebuild archive \
        -project objc-sdk-example.xcodeproj \
        -scheme objc-sdk-example \
	-destination "generic/platform=iOS" \
	-archivePath "archives/objc-sdk-example-iOS" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        SKIP_INSTALL=NO

xcodebuild archive \
        -project objc-sdk-example.xcodeproj \
        -scheme objc-sdk-example \
	-destination "generic/platform=iOS Simulator" \
	-archivePath "archives/objc-sdk-example-iOS-Simulator" \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        SKIP_INSTALL=NO

xcodebuild -create-xcframework \
	   -archive archives/objc-sdk-example-iOS.xcarchive -library libobjc-sdk-example.a -headers archives/objc-sdk-example-iOS.xcarchive/Products/usr/local/lib/include \
	   -archive archives/objc-sdk-example-iOS-Simulator.xcarchive -library libobjc-sdk-example.a -headers archives/objc-sdk-example-iOS-Simulator.xcarchive/Products/usr/local/lib/include \
           -output objc-sdk-example.xcframework
