#!/bin/bash

# PROJECT_PATH="D:\Workspace\flutter-app"
# chmod a+x update_ios.sh;

# cd $PROJECT_PATH
cd ios
pod deintegrate
pod repo update
pod update
cd ..
flutter clean
flutter pub upgrade
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
cd ios
pod install
