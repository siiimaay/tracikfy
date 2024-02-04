import 'package:feelify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:feelify/features/dashboard/presentation/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logo.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

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
                        text: "Dashboard",
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(0);
                        },
                      ),
                      TabView(
                        isSelected: state.currentIndex == 1,
                        text: 'Candidates',
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(1);
                        },
                      ),
                      TabView(
                        isSelected: state.currentIndex == 2,
                        text: 'Companies',
                        onTap: () {
                          context.read<DashboardCubit>().updateSelection(2);
                        },
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
