import 'package:flutter/foundation.dart';
import 'package:{{PACKAGE_NAME}}/data/service/logger/logger.dart';

/// logs into the system console
class DebugPrintLogging implements LoggingLibrary {
  DebugPrintLogging();
  bool enabled = true;

  @override
  Future<void> init() async {}

  @override
  Future<void> exception(Object e, StackTrace t) async {
    if (!enabled) return;

    debugPrint('''
  \n\nException $e\nstackTrace:\n$t\n\n
    ''');
  }

  @override
  Future<void> message(String message) async {
    if (!enabled) return;
    debugPrint(message);
  }

  @override
  void disable() => enabled = false;

  @override
  void enable() => enabled = true;
}
