## Tracking SDK and a sample app

### Library can be added as gradle dependency

Add this in repositories block of app/build.gradle
```
mavenCentral()
maven { url 'https://skyhookwireless.github.io/skyhook-location-android' }
```

This in dependencies block of app/build.gradle
```
implementation 'sh.locus:lotr.sdk:1.0.16'

// Optional. Add when LOTR server models are used
implementation 'sh.locus.lotr:lotr-javasdk:1.1.2'

// Optional for RxJava based APIs
implementation 'io.reactivex.rxjava2:rxandroid:2.1.1'
implementation 'io.reactivex.rxjava2:rxjava:2.2.19'
```

This in android block of app/build.gradle
```
packagingOptions {
    resources {
        excludes += ['META-INF/jersey-module-version']
    }
}
```
If minSdkVersion of your project is less than 23, add the following in the manifest
```
<uses-sdk tools:overrideLibrary="androidx.security"/>
```
The SDK uses library only when running on a device with SDK level 23 or more.

### compileSdkVersion
31

### Kotlin gradle plugin version
1.6.10

### Permissions

App that uses the tracking library must prompt user to grant these permissions
```
Manifest.permission.ACCESS_FINE_LOCATION
Manifest.permission.ACCESS_COARSE_LOCATION
Manifest.permission.ACCESS_BACKGROUND_LOCATION (if OS version >= 29)
Manifest.permission.ACTIVITY_RECOGNITION (if OS version >= 29)
Manifest.permission.READ_PHONE_STATE (if OS version < 29)
```

### Device identifier

The library requires a unique device ID to differentiate the devices.

- If the app has `Manifest.permission.READ_PHONE_STATE`, the sdk will use encoded IMEI or SERIAL ID of the device as the unique ID.
- Or app can provide a unique device ID in `LocusLotrSdk.init()` with `deviceId` property in `UserAuthParams` or `ClientAuthParams`
- Or if none of the above cases is valid, the library will generate random UUID on initialisation.

### Build failure due to method count being exceeded

It is possible that builds without minify (eg. debug) will fail due to exceeding method count limit.
Enable multidex for the required build types by adding this line in build type closure.
```
multiDexEnabled true
```

### Build failure due to multiple `META-INF/jersey-module-version` files

Include the following lines in android closure
```
packagingOptions {
    exclude 'META-INF/jersey-module-version'
}
```
