import 'package:feelify/features/candidate/presentation/candidate_view.dart';
import 'package:feelify/features/company/presentation/company_view.dart';
import 'package:feelify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:feelify/features/dashboard/presentation/dashboard_view.dart';
import 'package:feelify/features/dashboard/presentation/widgets/tab.dart';
import 'package:feelify/features/data/dashboard_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'logo.dart';

class DrawerView extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const DrawerView({Key? key, required this.drawerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          width: 300,
          color: const Color(0xff09093b),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Logo(),
                const Divider(
                  color: Colors.white,
                  thickness: 0.8,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      TabView(
                        isSelected: state.currentIndex == 0,
                        text: DashboardSection.dashboard.name,
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(0);

                          context.go(DashboardView.route);
                          // drawerKey.currentState?.closeDrawer();
                        },
                        prefix: const Icon(Icons.dashboard_outlined),
                      ),
                      TabView(
                        isSelected: state.currentIndex == 1,
                        text: DashboardSection.candidate.name,
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(1);
                          context.go(CandidateView.route);
                         // drawerKey.currentState?.closeDrawer();

                        },
                        prefix: const Icon(Icons.people_outline),
                      ),
                      TabView(
                        isSelected: state.currentIndex == 2,
                        text: DashboardSection.companies.name,
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(2);
                          context.go(CompanyView.route);
                        },
                        prefix: const Icon(Icons.business),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
