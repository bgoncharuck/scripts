import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

GoRoute ntGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<RouteBase> routes = const <RouteBase>[],
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  return GoRoute(
    path: path,
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: builder(context, state),
    ),
    routes: routes,
  );
}

// GoRoute fadeGoRoute({
//   required String path,
//   required Widget Function(BuildContext, GoRouterState) pageBuilder,
//   List<RouteBase> routes = const <RouteBase>[],
//   GlobalKey<NavigatorState>? parentNavigatorKey,
// }) {
//   return GoRoute(
//     path: path,
//     parentNavigatorKey: parentNavigatorKey,
//     pageBuilder: (context, state) => CustomTransitionPage<void>(
//       key: state.pageKey,
//       transitionDuration: const Duration(milliseconds: 300),
//       child: pageBuilder(context, state),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: CurveTween(curve: Curves.easeIn).animate(animation),
//           child: child,
//         );
//       },
//     ),
//   );
// }
