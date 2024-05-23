import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/candidate/bloc/employee_bloc.dart';
import 'package:trackify/features/candidate/widgets/current_employees_widget.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_card.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_widget.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';

import '../../core/injection/locator.dart';
import 'data/employee_status.dart';
import 'data/employee_ui_model.dart';

class CandidateView extends StatefulWidget {
  static const route = "/candidate_view";

  const CandidateView({Key? key}) : super(key: key);

  @override
  State<CandidateView> createState() => _CandidateViewState();
}

class _CandidateViewState extends State<CandidateView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      selectedIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWrapper(
      child: Stack(
        children: [
          BlocProvider(
            create: (context) => getIt.get<EmployeeBloc>(),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.color.appThemeMainColor,
                    border: Border.all(color: Colors.white70),
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  dividerColor: Colors.transparent,
                  unselectedLabelStyle:
                      const TextStyle(color: Color(0xFF4C4E59)),
                  unselectedLabelColor: context.color.appThemeMainColor,
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0x1a243ffa),
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "Current Employees",
                              style: context.textStyle.detailText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0x1a243ffa),
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "Candidates",
                              style: context.textStyle.detailText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Search here
                const SizedBox(height: 30),
                Expanded(
                  child: TabBarView(controller: tabController, children: const [
                    EmployeesView(),
                    EmployeesView(isCandidate: true),
                  ]),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.color.appThemeMainColor,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 24)),
                  onPressed: () {
                    context.push(
                        "${CandidateView.route}/${EmployeeDetailView.route}",
                        );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                      ),
                      SizedBox(width: 6),
                      Text("Employee")
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
