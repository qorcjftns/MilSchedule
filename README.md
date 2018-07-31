
## MilSchedule

간단고 강력한 스케쥴링 앱입니다.

## to build...

참고: https://medium.com/@authmane512/how-to-build-an-apk-from-command-line-without-ide-7260e1e22676

```
# compile android R.java
cd /opt/android-sdk/build-tools/26.0.1/
./aapt package -f -m -J $PROJ/src -M $PROJ/AndroidManifest.xml -S $PROJ/res -I /opt/android-sdk/platforms/android-19/android.jar
```

```
# compile java files
cd /path/to/AndroidHello
javac -d obj -classpath src -bootclasspath /opt/android-sdk/platforms/android-19/android.jar src/com/example/helloandroid/*.java
```

```
#javac classpash setting for android
javac -d obj -classpath "src:libs/<your-lib>.jar" -bootclasspath /opt/android-sdk/platforms/android-19/android.jar src/com/example/helloandroid/*.java
```

```
# dx
cd /opt/android-sdk/build-tools/26.0.1/
./dx --dex --output=$PROJ/bin/classes.dex $PROJ/obj

# for external lib...
./dx --dex --output=$PROJ/bin/classes.dex $PROJ/*.jar $PROJ/obj
```

```
# compile!
cd /path/to/AndroidHello
javac -d obj -source 1.7 -target 1.7 -classpath src -bootclasspath /opt/android-sdk/platforms/android-19/android.jar src/com/example/helloandroid/*.java
```

```
# Create APK file
./aapt package -f -m -F $PROJ/bin/hello.unaligned.apk -M $PROJ/AndroidManifest.xml -S $PROJ/res -I /opt/android-sdk/platforms/android-19/android.jar
cp $PROJ/bin/classes.dex .
./aapt add $PROJ/bin/hello.unaligned.apk classes.dex
```

```
# list packages in apk
./aapt list $PROJ/bin/hello.unaligned.apk
```

Now, we need to sign the packege...

```
# key tool provided by java
keytool -genkeypair -validity 365 -keystore mykey.keystore -keyalg RSA -keysize 2048
```

```
# sign it using apksigner
./apksigner sign --ks mykey.keystore $PROJ/bin/hello.apk
```

```
# align package..!
./zipalign -f 4 $PROJ/bin/hello.unaligned.apk $PROJ/bin/hello.apk
```


...OR YOU CAN JUST RUN `build.sh` from git-bash.exe


## VS Code
Extension List:
 * Java Extension Pack
 * git