#!/bin/bash

# PROJECT_PATH="D:\Workspace\flutter-app"

# cd $PROJECT_PATH
flutter clean
flutter pub upgrade
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
