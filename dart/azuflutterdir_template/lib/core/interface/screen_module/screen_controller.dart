abstract class ScreenControllerParams {}

class ScreenController<T extends ScreenControllerParams> {
  const ScreenController(this.params);
  final T params;
}
