import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../features/company/presentation/widgets/employee_image_widget.dart';

class ExpandableSection extends StatelessWidget {
  final String sectionName;

  const ExpandableSection({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: true,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  child: Text(sectionName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),)),
              collapsed: const SizedBox.shrink(),
              expanded: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 28,
                    runSpacing: 40,
                    children: <Widget>[
                      for (var _ in Iterable.generate(17))
                        const EmployeeInfoWidget(
                          name: "Simay Ekici",
                        )
                    ],
                  ),
                ),
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
