import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:{{PACKAGE_NAME}}/core/routing/routes.dart';
import 'package:{{PACKAGE_NAME}}/core/routing/transition.dart';

GoRouter declarativeRouter() => GoRouter(
  initialLocation: homeRoute,
  routes: <GoRoute>[
    GoRoute(
      path: homeRoute,
      builder: (context, state) => const SizedBox.shrink(),
    ),
    // ntGoRoute(
    //   path: exampleScreenRoute,
    //   builder: (context, state) => const SizedBox.shrink(),
    // ),
  ],
);
