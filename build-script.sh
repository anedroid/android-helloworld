#!/bin/bash
ANDROID_SDK_ROOT=/usr/lib/android-sdk
_APK_BASENAME="Application"
_INTERMEDIATE="bin gen ${_APK_BASENAME}.apk.unaligned classes.dex"
_PLATFORM=$(ls $ANDROID_SDK_ROOT/platforms | sort -n | tail -1)
_ANDROID_CP=$ANDROID_SDK_ROOT/platforms/$_PLATFORM/android.jar

clear
rm -rf $_INTERMEDIATE
mkdir bin gen

printf "> Generating R.java\n"
aapt package -f -m -J gen -M AndroidManifest.xml -S res -I $_ANDROID_CP # Tworzenie R.java

printf "\n> Compiling classes\n"
javac -classpath $_ANDROID_CP -sourcepath 'src:gen' -d 'bin' -target 1.7 -source 1.7 `find . -name "*.java"` # Kompilowanie klas Javy

printf "\n> Generating classes.dex\n"
$ANDROID_SDK_ROOT/build-tools/debian/dx --dex --output=classes.dex bin # Tworzenie classes.dex

printf "\n> Generating apk\n"
aapt package -f -M AndroidManifest.xml -S res -I $_ANDROID_CP -F $_APK_BASENAME.apk.unaligned # Tworzenie pliku apk (z resources.arsc)
aapt add $_APK_BASENAME.apk.unaligned classes.dex # Dodawanie classes.dex do apk

printf "\n> Signing\n"
jarsigner -keystore ~/.android/debug.keystore -storepass 'android' $_APK_BASENAME.apk.unaligned androiddebugkey # Podpisywanie apk

printf "\n> Zip alignment\n"
zipalign -f 4 $_APK_BASENAME.apk.unaligned $_APK_BASENAME-debug.apk # zip alignment (Application-debug.apk)

rm -rf $_INTERMEDIATE

printf "\n> Installing\n"
adb install $_APK_BASENAME-debug.apk
