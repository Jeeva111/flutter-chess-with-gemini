import 'package:chess/game.dart';
import 'package:chess/menu.dart';
import 'package:go_router/go_router.dart';

final routers = GoRouter(
  routes: [
    GoRoute(
      name: AppRoutes.root.name,
      path: AppRoutes.root.name,
      builder: (context, state) => const MenuScreen(),
      routes: [
        GoRoute(
          name: AppRoutes.game.name,
          path: AppRoutes.game.name,
          builder: (context, state) => const ChessGame(),
        ),
      ],
    ),
  ],
);

enum AppRoutes {
  root(name: "/"),
  game(name: "game"),
  options(name: "options");
  final String name;
  const AppRoutes({required this.name});
}

extension AppRoutePath on AppRoutes {

}