import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/company/data/repository/company_repository.dart';

import 'package:trackify/features/company/presentation/widgets/new_company_view.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';
import 'package:trackify/features/dashboard/presentation/widgets/frame_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/injection/locator.dart';
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
          color: context.color.settingsBackColor,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              BlocBuilder<CompanyCubit, CompanyState>(
                  buildWhen: (previous, current) =>
                      previous.companies != current.companies ||
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    if (state.isLoading) {
                      context.loaderOverlay.show();
                    }
                    if (state.companies.isEmpty) {
                      context.loaderOverlay.hide();
                      return Center(
                        child: Text(
                          "There is no company, let's create one!",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: context.color.appThemeMainColor,
                              fontSize: 16),
                        ),
                      );
                    } else {
                      context.loaderOverlay.hide();
                      return StreamBuilder(
                          stream:
                              getIt.get<CompanyRepository>().listenCompanies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if ((snapshot.data!).isNotEmpty) {
                              final companyList = snapshot.data!
                                  .where((element) =>
                                      element.isDeactivated != true)
                                  .toList();

                              return GridView.builder(
                                itemCount: companyList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Frame(
                                    label: companyList[index].company,
                                    company: companyList[index],
                                  );
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          });
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
