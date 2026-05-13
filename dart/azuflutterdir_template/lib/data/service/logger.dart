import 'dart:developer' as developer;

/// Lightweight project logger; swap implementation if you add remote logging.
class Logger {
  const Logger();

  void message(String text, {String name = 'app'}) {
    developer.log(text, name: name);
  }
}
