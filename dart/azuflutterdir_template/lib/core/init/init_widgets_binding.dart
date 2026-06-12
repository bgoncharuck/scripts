import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../locator.dart';

Future<WidgetsBinding> initWidgetsBinding() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// turns splash screen preservation on/off
  // widgetsBinding.preserveSplashScreen();
  return widgetsBinding;
}

class SplashScreenStopped {
  /// file-private field + extension,
  /// a variation of Open-Closed principle to expand functionality
  /// without changing a class
  var _splashScreenStopped = false;
}

extension NativeSplashPreservation on WidgetsBinding {
  void preserveSplashScreen() {
    FlutterNativeSplash.preserve(widgetsBinding: this);
  }

  void removeSplashScreen() {
    /// native splash can be removed only once
    if (locator.get<SplashScreenStopped>()._splashScreenStopped) {
      return;
    }
    FlutterNativeSplash.remove();
    locator.get<SplashScreenStopped>()._splashScreenStopped = true;
  }
}
