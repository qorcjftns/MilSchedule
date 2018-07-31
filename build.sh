#!/bin/bash

set -e

AAPT="/c/Users/Administrator/Downloads/sdk-tools-windows-4333796/build-tools/27.0.3/aapt"
DX="/c/Users/Administrator/Downloads/sdk-tools-windows-4333796/build-tools/27.0.3/dx"
ZIPALIGN="/c/Users/Administrator/Downloads/sdk-tools-windows-4333796/build-tools/27.0.3/zipalign"
APKSIGNER="/c/Users/Administrator/Downloads/sdk-tools-windows-4333796/build-tools/26.0.1/apksigner" # /!\ version 26
PLATFORM="/c/Users/Administrator/Downloads/sdk-tools-windows-4333796/platforms/android-26/android.jar"

echo "Cleaning..."
rm -rf obj/*
rm -rf src/com/cheulsoon/milschedule/R.java

echo "Generating R.java file..."
$AAPT package -f -m -J src -M AndroidManifest.xml -S res -I $PLATFORM

echo "Compiling..."
/c/Program\ Files/Java/jdk1.8.0_181/bin/javac -d obj -source 1.7 -target 1.7 -classpath src -bootclasspath $PLATFORM src/com/example/helloandroid/*.java
/c/Program\ Files/Java/jdk1.8.0_181/bin/javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/cheulsoon/milschedule/MainActivity.java
/c/Program\ Files/Java/jdk1.8.0_181/bin/javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/example/helloandroid/R.java

echo "Translating in Dalvik bytecode..."
$DX --dex --output=classes.dex obj

echo "Making APK..."
$AAPT package -f -m -F bin/hello.unaligned.apk -M AndroidManifest.xml -S res -I $PLATFORM
$AAPT add bin/hello.unaligned.apk classes.dex

echo "Aligning and signing APK..."
$APKSIGNER sign --ks mykey.keystore bin/hello.unaligned.apk
$ZIPALIGN -f 4 bin/hello.unaligned.apk bin/hello.apk

if [ "$1" == "test" ]; then
	echo "Launching..."
	adb install -r bin/hello.apk
	adb shell am start -n com.example.helloandroid/.MainActivity
fi