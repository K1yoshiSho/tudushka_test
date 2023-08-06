// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/services/get_it.dart';

/// [Talker] - This class contains methods for handling errors and logging.

/// `initTalker` - This function initializes Talker.

Future<void> initTalker({required Talker talker}) async {
  FlutterError.presentError = (details) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      talker.handle(details.exception, details.stack);
    });
  };

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: true,
      printChanges: false,
      printStateFullData: true,
    ),
  );

  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<Talker>().handle(error, stack);
    return true;
  };

  FlutterError.onError = (details) => getIt<Talker>().handle(details.exception, details.stack);
}
