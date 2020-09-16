## Tracking SDK and a sample app

### Library can be added as gradle dependency

Add this in repositories block of app/build.gradle
```
maven { url 'https://locus.bintray.com/locus-lotr-sdk' }
```

and this in dependencies block of app/build.gradle
```
implementation 'sh.locus:lotr.sdk:1.0.11'
```


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
