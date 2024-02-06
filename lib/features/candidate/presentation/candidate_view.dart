import 'package:flutter/material.dart';

import '../../dashboard/presentation/widgets/frame_widget.dart';

class CandidateView extends StatelessWidget {
  static const route = "/candidate_view";
  const CandidateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 12,
          spacing: 24,
          children: [
            Frame(label: "Seven"),
            Frame(label: "Seven"),
            Frame(label: "Seven"),
            Frame(label: "Seven"),
            Frame(label: "Seven"),
            Frame(label: "Seven"),
          ],
        ),
      ),
    );
  }
}
