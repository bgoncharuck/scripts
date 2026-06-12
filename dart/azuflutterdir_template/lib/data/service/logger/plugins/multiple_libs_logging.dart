import 'package:flutter/foundation.dart';
import 'package:{{PACKAGE_NAME}}/data/service/logger/logger.dart';
import 'package:{{PACKAGE_NAME}}/data/service/logger/plugins/debug_print.dart';

/// A logging implementation that aggregates logging
/// from multiple logging libraries.
class MultipleLibrariesLogging implements LoggingLibrary {
  /// The list of logging libraries to be used.
  final Iterable<LoggingLibrary> libraries = [
    // const SentryLogging(),
    if (kDebugMode || kProfileMode) DebugPrintLogging(),
  ];

  @override
  Future<void> init() async {
    for (final lib in libraries) {
      await lib.init();
    }
  }

  @override
  Future<void> exception(Object e, StackTrace t) async {
    for (final lib in libraries) {
      await lib.exception(e, t);
    }
  }

  @override
  Future<void> message(String message) async {
    for (final lib in libraries) {
      await lib.message(message);
    }
  }

  @override
  void disable() {
    for (final lib in libraries) {
      lib.disable();
    }
  }

  @override
  void enable() {
    for (final lib in libraries) {
      lib.enable();
    }
  }
}
