import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';



class SectionLabelWidget extends StatelessWidget {
  final String label;

  const SectionLabelWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.012,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppFontSize.overline(context),
          fontWeight: AppFontWeight.bold,
          color: AppColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}