import 'package:flutter/material.dart';

@immutable
class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  final Color settingsBackColor;
  final Color settingsItemColor;
  final Color settingsItemBorderColor;
  final Color toolTipBehaviorColor;
  final Color closeButtonColor;
  final Color closeButtonIconColor;
  final Color successColor;
  final Color logoutTextColor;
  final Color accountInfoColor;
  final Color settingsItemShadow;
  final Color textFieldBackColor;
  final Color retryColor;

  const ColorThemeExtension(
      {required this.settingsBackColor,
      required this.toolTipBehaviorColor,
      required this.closeButtonColor,
      required this.closeButtonIconColor,
      required this.settingsItemColor,
      required this.settingsItemBorderColor,
      required this.successColor,
      required this.logoutTextColor,
      required this.accountInfoColor,
      required this.settingsItemShadow,
      required this.textFieldBackColor,
      required this.retryColor});

  @override
  ThemeExtension<ColorThemeExtension> copyWith() {
    return ColorThemeExtension(
        settingsBackColor: settingsBackColor,
        accountInfoColor: accountInfoColor,
        retryColor: retryColor,
        settingsItemColor: settingsItemColor,
        settingsItemBorderColor: settingsItemBorderColor,
        toolTipBehaviorColor: toolTipBehaviorColor,
        closeButtonColor: closeButtonColor,
        closeButtonIconColor: closeButtonIconColor,
        successColor: successColor,
        logoutTextColor: logoutTextColor,
        settingsItemShadow: settingsItemShadow,
        textFieldBackColor: textFieldBackColor);
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
      covariant ThemeExtension<ColorThemeExtension>? other, double t) {
    return ColorThemeExtension(
        retryColor: retryColor,
        settingsItemBorderColor: settingsItemBorderColor,
        accountInfoColor: accountInfoColor,
        settingsBackColor: settingsBackColor,
        settingsItemColor: settingsItemColor,
        toolTipBehaviorColor: toolTipBehaviorColor,
        closeButtonColor: closeButtonColor,
        closeButtonIconColor: closeButtonIconColor,
        successColor: successColor,
        logoutTextColor: logoutTextColor,
        settingsItemShadow: settingsItemShadow,
        textFieldBackColor: textFieldBackColor);
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static const light = ColorThemeExtension(
      accountInfoColor: Color(0xff5C5E6A),
      settingsItemBorderColor: Color(0xffC6C5CA),
      settingsBackColor: Color(0xffF9F9F9),
      settingsItemColor: Colors.white,
      retryColor: Color(0xffee444414),
      logoutTextColor: Color(0xffDF0000),
      toolTipBehaviorColor: Color(0xff1C1C1E),
      closeButtonColor: Color(0xffdedfe7),
      closeButtonIconColor: Color(0xff7787F3),
      successColor: Color(0xff63BB37),
      settingsItemShadow: Color(0x00c7c7c7),
      textFieldBackColor: Colors.white);

  static const dark = ColorThemeExtension(
    settingsItemBorderColor: Color(0xff444348),
    settingsBackColor: Color(0xff1C1C1E),
    settingsItemColor: Color(0xff2C2C2E),
    retryColor: Color.fromRGBO(238, 68, 68, 0.08),
    logoutTextColor: Color(0xffDF0000),
    closeButtonColor: Color(0xff7787F3),
    closeButtonIconColor: Color(0xff212121),
    toolTipBehaviorColor: Color(0xffdddee1),
    successColor: Color(0xff63BB37),
    settingsItemShadow: Color(0xff343434),
    textFieldBackColor: Color(0xff121212),
    accountInfoColor: Color(0xff121212),
  );
}
