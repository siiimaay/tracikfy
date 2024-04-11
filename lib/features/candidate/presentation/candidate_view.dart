import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/candidate/widgets/employee_detail_card.dart';

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
    return Scaffold(
      body: Column(
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
            unselectedLabelStyle: const TextStyle(color: Color(0xFF4C4E59)),
            unselectedLabelColor: context.color.appThemeMainColor,
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0x1a243ffa),
                  ),
                  child: const SizedBox(
                    child: Center(
                      child: Text("Current Employees"),
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
                  child: const SizedBox(
                    child: Center(
                      child: Text("Candidates"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Search here
          SizedBox(height: 30),
          Expanded(
            child: TabBarView(controller: tabController, children:  [
              ListView.builder(
                  itemCount: 10,

                  itemBuilder: (context, index) {
                    return const EmployeeDetailCard();
                  }),
              Center(child: Text("candidate")),
            ]),
          )
        ],
      ),
    );
  }
}
