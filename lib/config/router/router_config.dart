import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackify/features/auth/presentation/login_view.dart';
import 'package:trackify/features/candidate/employee_view.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_widget.dart';
import 'package:trackify/features/candidate/widgets/existing_employee_detail_view.dart';
import 'package:trackify/features/company/presentation/company_view.dart';
import 'package:trackify/features/company/presentation/widgets/new_company_view.dart';
import 'package:trackify/features/dashboard/presentation/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trackify/features/meeting/presentation/add_meeting_screen.dart';
import 'package:trackify/features/meeting/presentation/meeting_view.dart';

import '../../features/auth/presentation/sign_up_view.dart';
import '../../features/candidate/data/employee.dart';
import '../../features/candidate/data/employee_ui_model.dart';
import '../../features/company/data/company.dart';
import '../../features/company/presentation/widgets/company_details_view.dart';

class AppRouterConfig {
  static final _instance = AppRouterConfig._internal();

  static AppRouterConfig get instance => _instance;
  late final GoRouter router;

  factory AppRouterConfig() {
    return _instance;
  }

  final appRouter = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      initialLocation: SignUpView.route,
      routes: [
        GoRoute(
          path: DashboardView.route,
          builder: (BuildContext context, GoRouterState state) =>
              const DashboardView(),
        ),
        GoRoute(
          path: LoginView.route,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginView(),
        ),
        GoRoute(
          path: MeetingView.route,
          routes: [
            GoRoute(
              path: AddMeetingScreen.route,
              builder: (BuildContext context, GoRouterState state) =>
                  const AddMeetingScreen(),
            ),
          ],
          builder: (context, state) {
            return const MeetingView();
          },
        ),
        GoRoute(
          redirect: (BuildContext context, GoRouterState state) {
            final hasUserLoggedIn =
                FirebaseAuth.instance.currentUser?.uid != null;

            if (hasUserLoggedIn) {
              return DashboardView.route;
            } else {
              return null;
            }
          },
          path: SignUpView.route,
          builder: (BuildContext context, GoRouterState state) =>
              const SignUpView(),
        ),
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
                    GoRoute(
                        path: ExistingEmployeeDetailView.route,
                        builder: (context, state) {
                          final employeeDetail = state.extra as EmployeeData;
                          return ExistingEmployeeDetailView(
                              employee: employeeDetail);
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
                          final companyDetail = state.extra as Company;

                          return CompanyDetailView(
                            company: companyDetail,
                          );
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
