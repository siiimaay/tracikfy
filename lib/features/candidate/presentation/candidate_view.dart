import 'package:flutter/cupertino.dart';

import '../../dashboard/presentation/widgets/frame_widget.dart';

class CandidateView extends StatelessWidget {
  const CandidateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
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
    );
  }
}
