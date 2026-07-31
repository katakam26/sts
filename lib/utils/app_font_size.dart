import 'package:flutter/cupertino.dart';

class AppFontSize {
  AppFontSize._();

  static double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width / 375; // Reference device width
  }

  /// Headings
  static double h1(BuildContext context) => 32 * _scale(context);
  static double h2(BuildContext context) => 28 * _scale(context);
  static double h3(BuildContext context) => 24 * _scale(context);
  static double h4(BuildContext context) => 20 * _scale(context);
  static double h5(BuildContext context) => 18 * _scale(context);
  static double h6(BuildContext context) => 16 * _scale(context);

  /// Body Text
  static double text(BuildContext context) => 16 * _scale(context);
  static double text2(BuildContext context) => 15 * _scale(context);
  static double text3(BuildContext context) => 14 * _scale(context);

  /// Small Text
  static double small(BuildContext context) => 13 * _scale(context);
  static double caption(BuildContext context) => 12 * _scale(context);

  /// Tiny Text
  static double overline(BuildContext context) => 11 * _scale(context);
  static double tiny(BuildContext context) => 10 * _scale(context);

  /// Custom Size
  static double custom(BuildContext context, double size) =>
      size * _scale(context);
}
