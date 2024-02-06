import 'package:feelify/features/candidate/presentation/candidate_view.dart';
import 'package:feelify/features/dashboard/presentation/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static final _instance = AppRouterConfig._internal();

  static AppRouterConfig get instance => _instance;
  late final GoRouter router;

  factory AppRouterConfig() {
    return _instance;
  }

  AppRouterConfig._internal() {
    router = GoRouter(routes: _routes, initialLocation: DashboardView.route);
  }

  final _routes = [
    GoRoute(
      path: DashboardView.route,
      pageBuilder: (context, GoRouterState state) {
        return const MaterialPage(child: DashboardView());
      },
    ),
    GoRoute(
      path: CandidateView.route,
      pageBuilder: (context, GoRouterState state) {
        return const MaterialPage(child: CandidateView());
      },
    ),
  ];

  /*static StatefulShellRoute _setupSideBar() {
    return StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: DashboardView.route,
              builder: (context, state) {
                return const DashboardView();
              },
            ),
            GoRoute(
              path: DashboardView.route,
              builder: (context, state) {
                return const CandidateView();
              },
            ),
          ])
        ],
        pageBuilder: (context, state, navigationShell) {
          return DashboardView()
        });
  }*/
}
