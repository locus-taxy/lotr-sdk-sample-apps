#!/bin/bash

current_path=$(pwd)
cd ../../LocusTrackingSdk/ || exit 1
./gradlew clean aR || exit 1
cp app/build/outputs/aar/app-release.aar "$current_path"/ || exit 1
cd "$current_path" || exit 1
