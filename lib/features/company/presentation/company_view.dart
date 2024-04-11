import 'package:go_router/go_router.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/presentation/new_company_view.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    foregroundColor: Colors.white,
                      elevation: 8,

                      backgroundColor: context.color.appThemeMainColor,
                      onPressed: () {
                        context.push(NewCompanyDetailForm.route);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 36,
                      )),
                  //const SizedBox(width: 8),
              //    FloatingActionButton(onPressed: () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
