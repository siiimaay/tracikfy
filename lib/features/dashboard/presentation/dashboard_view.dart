import 'package:feelify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:feelify/features/dashboard/presentation/widgets/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  static const route = "/";

  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerView(),
        body: const Center(
          child: Text("center"),
        ),
      ),
    );
  }
}
