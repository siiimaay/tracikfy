import 'package:trackify/config/router/router_config.dart';
import 'package:trackify/theme/text_theme_extension.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true, extensions: [TextThemeExtension.textStyles()]),
      routerConfig: AppRouterConfig.instance.appRouter,
    );
  }
}
