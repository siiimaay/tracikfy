import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';
import 'package:trackify/features/dashboard/presentation/widgets/drawer_view.dart';

class AppBarWrapper extends StatelessWidget {
  final Widget? child;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBarWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.color.settingsBackColor,
      appBar: AppBar(
        shadowColor: context.color.settingsBackColor,
      ),
      drawer: DrawerView(drawerKey: _scaffoldKey),
      body: child,
    );
  }
}
