import 'package:trackify/features/candidate/employee_view.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_widget.dart';
import 'package:trackify/features/company/presentation/company_view.dart';
import 'package:trackify/features/company/presentation/new_company_view.dart';
import 'package:trackify/features/dashboard/presentation/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/company/presentation/company_details_view.dart';

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
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return DashboardView(child: child);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: CandidateView.route,
                  routes: [
                    GoRoute(
                        path: EmployeeDetailView.route,
                        builder: (context, state) {
                          return const EmployeeDetailView();
                        }),
                  ],
                  builder: (context, state) {
                    return const CandidateView();
                  },
                ),
                GoRoute(
                  path: CompanyView.route,
                  routes: [
                    GoRoute(
                        path: CompanyDetailView.route,
                        builder: (context, state) {
                          return const CompanyDetailView();
                        }),
                    GoRoute(
                      path: NewCompanyDetailForm.route,
                      builder: (context, state) {
                        return const NewCompanyDetailForm();
                      },
                    ),
                  ],
                  builder: (context, state) {
                    return const CompanyView();
                  },
                ),
              ],
            )
          ],
        )
      ]);

  AppRouterConfig._internal();
}
