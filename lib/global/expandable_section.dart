import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableSection extends StatelessWidget {
  const ExpandableSection({super.key});

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
          header: const Padding(
              padding: EdgeInsets.all(10), child: Text("ExpandablePanel")),
          collapsed: const Text(
            "loremIpsum",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var _ in Iterable.generate(5))
                const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "loremIpsum",
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    )),
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
