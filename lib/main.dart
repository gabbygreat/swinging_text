import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/screen/home.dart';
import 'package:learn/screen/main.dart';
import 'package:learn/screen/profile.dart';
import 'package:learn/screen/settings.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    const FlutterExample(),
  );
}

GoRouter routes = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          shell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class FlutterExample extends StatefulWidget {
  const FlutterExample({super.key});

  @override
  State<FlutterExample> createState() => _FlutterExampleState();
}

class _FlutterExampleState extends State<FlutterExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
    );
  }
}
