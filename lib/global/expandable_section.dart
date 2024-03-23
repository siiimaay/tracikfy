import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';


class ExpandableSection extends StatelessWidget {
  final String sectionName;

  const ExpandableSection({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToCollapse: true,
          ),
          header: Padding(
              padding: const EdgeInsets.all(10), child: Text(sectionName)),
          collapsed: const SizedBox.shrink(),
          expanded: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 24,
            runSpacing: 40,
            children: <Widget>[
              for (var _ in Iterable.generate(18)) const Text("Employee info")
            ],
          ),
          builder: (_, collapsed, expanded) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                collapsed: collapsed,
                expanded: expanded,
                theme: const ExpandableThemeData(crossFadePoint: 0),
              ),
            );
          },
        ),
      ),
    );
  }
}
