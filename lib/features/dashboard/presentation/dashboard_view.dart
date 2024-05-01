import 'package:go_router/go_router.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/dashboard/app_bar_wrapper.dart';
import 'package:trackify/features/dashboard/presentation/dashboard_cubit.dart';
import 'package:trackify/features/dashboard/presentation/widgets/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  final Widget? child;
  static const route = "/dashboard";

  const DashboardView({Key? key, this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return child ??
        AppBarWrapper(
          child: child,
        );
  }
}
