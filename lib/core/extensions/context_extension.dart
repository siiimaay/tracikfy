import 'package:flutter/material.dart';

import '../../theme/color_theme_extension.dart';
import '../../theme/text_theme_extension.dart';

extension ContextExtension on BuildContext {
  TextThemeExtension get textStyle =>
      Theme.of(this).extension<TextThemeExtension>()!;

  ColorThemeExtension get color =>
      Theme.of(this).extension<ColorThemeExtension>()!;
}
