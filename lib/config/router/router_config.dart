import 'package:feelify/features/candidate/presentation/candidate_view.dart';
import 'package:feelify/features/company/presentation/company_view.dart';
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

  final appRouter = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: DashboardView.route,
      routes: [
        GoRoute(
            path: DashboardView.route,
            builder: (BuildContext context, GoRouterState state) =>
                DashboardView()),
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return DashboardView(child: child);
          },
          routes: [
            GoRoute(
              path: CandidateView.route,
              builder: (BuildContext context, GoRouterState state) =>
                  const CandidateView(),
            ),
            GoRoute(
              path: CompanyView.route,
              builder: (BuildContext context, GoRouterState state) =>
                  const CompanyView(),
            ),
          ],
        )
      ]);

  AppRouterConfig._internal();
}
