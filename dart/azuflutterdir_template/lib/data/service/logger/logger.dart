abstract class LoggingLibrary {
  Future<void> init();

  Future<void> exception(Object e, StackTrace t);
  Future<void> message(String message);

  void disable();
  void enable();
}
