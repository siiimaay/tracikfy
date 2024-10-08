import 'package:loader_overlay/loader_overlay.dart';
import 'package:trackify/config/router/router_config.dart';
import 'package:trackify/firebase_options.dart';
import 'package:trackify/theme/color_theme_extension.dart';
import 'package:trackify/theme/text_theme_extension.dart';
import 'package:flutter/material.dart';

import 'core/injection/locator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupInjection();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, extensions: [
          ColorThemeExtension.light,
          TextThemeExtension.textStyles(),
        ]),
        darkTheme: ThemeData(extensions: [
          ColorThemeExtension.dark,
          TextThemeExtension.textStyles(),
        ]),
        routerConfig: AppRouterConfig.instance.appRouter,
      ),
    );
  }
}
