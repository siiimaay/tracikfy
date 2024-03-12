import 'package:feelify/features/dashboard/presentation/widgets/frame_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyView extends StatelessWidget {
  static const route = "/company_view";

  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: const [
          Frame(label: "Seven"),
          Frame(label: "Seven"),
          Frame(label: "Seven"),
          Frame(label: "Seven"),
          Frame(label: "Seven"),
          Frame(label: "Seven")
        ],
      ),
    );
  }
}
