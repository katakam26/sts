import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.h5(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        InkWell(
          onTap: onViewAll,
          child: Text(
            'View All',
            style: TextStyle(
              fontSize: AppFontSize.text3(context),
              fontWeight: AppFontWeight.semiBold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
