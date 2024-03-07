import 'package:feelify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:feelify/features/dashboard/presentation/widgets/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  final Widget? child;
  static const route = "/";

  DashboardView({Key? key, this.child}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(),
          drawer: DrawerView(
            drawerKey: _scaffoldKey,
          ),
          body: child),
    );
  }
}
