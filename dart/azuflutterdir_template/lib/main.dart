import 'package:flutter/widgets.dart';
import 'package:{{PACKAGE_NAME}}/core/app.dart';
import 'package:{{PACKAGE_NAME}}/core/init/bootstrap.dart';

Future<void> main() async {
  await bootstrap();
  runApp(const App());
}
