import 'package:{{PACKAGE_NAME}}/core/interface/screen_module/screen_controller.dart';
import 'package:flutter/widgets.dart';

abstract class ScreenLocator<T extends ScreenController> extends InheritedWidget {
  const ScreenLocator({
    required this.controller,
    required super.child,
    super.key,
  });

  final T controller;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

// example
// class TestControllerParams extends ScreenControllerParams {}

// class TestController extends ScreenController<TestControllerParams> {
//   TestController(super.params);
// }

// class TestLocator extends ScreenLocator<TestController> {
//   const TestLocator({
//     required super.controller,
//     required super.child,
//     super.key,
//   });

//   static TestController of(BuildContext context) {
//     final widget = context.dependOnInheritedWidgetOfExactType<TestLocator>();
//     if (widget == null) {
//       throw FlutterError('TestLocator not found in BuildContext.');
//     }
//     return widget.controller;
//   }
// }
