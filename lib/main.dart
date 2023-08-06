import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/features/app/app.dart';
import 'package:tudushka/src/services/get_it.dart';
import 'package:tudushka/src/services/talker.dart';

void main() {
  runZonedGuarded(() async {
    // Sets debugZoneErrorsAreFatal to true which ensures that any errors occurring in the framework during startup are treated as fatal.
    BindingBase.debugZoneErrorsAreFatal = true;

    // Ensures that the Flutter app is initialized with WidgetsFlutterBinding.
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    // Preserves the native splash screen on the screen for some time and displays it until the Flutter app is fully loaded.
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Preserves the native splash screen on the screen for some time and displays it until the Flutter app is fully loaded.

    DartPluginRegistrant.ensureInitialized();
    // Initializes the talker service of the app.
    final Talker talker = TalkerFlutter.init();

    // Initializes the talker service.
    await initTalker(talker: talker);

    // Initializes the GetIt service locator container of the app.
    await initGetIt(talker: talker);
    getIt<Talker>().good("App started");
    runApp(const TudushkaApp());
  }, (error, stackTrace) {
    // Handles the error using the talker service.
    getIt<Talker>().handle(error, stackTrace);
  });
}
