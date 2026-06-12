import 'package:flutter/cupertino.dart';
import 'package:{{PACKAGE_NAME}}/core/routing/go_router.dart' show declarativeRouter;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: declarativeRouter(),
    );
  }
}
