import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/core/extensions/context_extension.dart';

import 'package:trackify/features/company/presentation/widgets/new_company_view.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';
import 'package:trackify/features/dashboard/presentation/widgets/frame_widget.dart';
import 'package:flutter/material.dart';

import 'company_cubit/company_cubit.dart';
import 'company_cubit/company_state.dart';

class CompanyView extends StatelessWidget {
  static const route = "/company_view";

  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarWrapper(
      child: BlocProvider<CompanyCubit>(
        create: (context) => CompanyCubit(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<CompanyCubit, CompanyState>(
                  buildWhen: (previous, current) =>
                      previous.companies != current.companies || previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    if (state.isLoading) {
                      context.loaderOverlay.show();
                    }
                    if (state.companies.isEmpty) {
                      context.loaderOverlay.hide();
                      return const Center(
                        child: Text("Empty"),
                      );
                    } else {
                      context.loaderOverlay.hide();
                      return GridView.builder(
                        itemCount: state.companies.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Frame(label: state.companies[index].company);
                        },
                      );
                    }
                  }),
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
                        context.push(
                            "${CompanyView.route}/${NewCompanyDetailForm.route}");
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
        ),
      ),
    );
  }
}
