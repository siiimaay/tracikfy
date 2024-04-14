import 'package:go_router/go_router.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/widgets/new_company_view.dart';
import 'package:trackify/features/dashboard/presentation/widgets/frame_widget.dart';
import 'package:flutter/material.dart';

class CompanyView extends StatelessWidget {
  static const route = "/company_view";

  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: const [
              Frame(),
              Frame(),
              Frame(),
              Frame(),
              Frame(),
              Frame()
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.color.appThemeMainColor,
                    foregroundColor: Colors.white,
                    elevation: 8,
                  ),
                  onPressed: () {
                    context.push("${CompanyView.route}/${NewCompanyDetailForm.route}");
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                      ),
                      SizedBox(width: 6),
                      Text("Company")
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
