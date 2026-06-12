import 'package:flutter/widgets.dart';

Future<WidgetsBinding> initWidgetsBinding() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  return widgetsBinding;
}
