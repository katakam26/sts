import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class TextTrailingWidget extends StatelessWidget {
  final String text;

  const TextTrailingWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: AppFontSize.text3(context),
            fontWeight: AppFontWeight.medium,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(width: screenWidth * 0.01),
        Icon(
          Icons.chevron_right,
          color: AppColors.textMuted,
          size: screenWidth * 0.06,
        ),
      ],
    );
  }
}