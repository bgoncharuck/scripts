import 'package:{{PACKAGE_NAME}}/core/init/init_widgets_binding.dart';
import 'package:{{PACKAGE_NAME}}/data/service/logger/plugins/multiple_libs_logging.dart';
import 'package:{{PACKAGE_NAME}}/core/locator.dart';

import '../locator.dart';

/// One-time startup (DI, services, cache). Call from [main] before [runApp] if needed.
Future<void> bootstrap() async {
  locator.registerSingleton<SplashScreenStopped>(SplashScreenStopped())
  locator.registerSingleton<LoggingLibrary>(MultipleLibrariesLogging());
  await locator.get<LoggingLibrary>().init();
  locator.registerSingleton<WidgetsBinding>(await initWidgetsBinding());
}
