import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

GetIt getIt = GetIt.I;

// Initializes the GetIt container with required services using lazy singleton pattern.
/// This function is called in [main] file.

initGetIt({required Talker talker}) async {
  /// Registers the [Talker] service as a singleton that is created once when first accessed.
  getIt.registerSingleton<Talker>(talker);
  // getIt.registerSingletonAsync<Isar>(() => IsarService.init());
  // getIt.registerSingletonAsync<Isar>(() => IsarService.init(), dependsOn: [Isar]);
}
