import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class DiaryCardWidget extends StatelessWidget {
  final String date;
  final String title;
  final String content;
  final String classBadge;

  const DiaryCardWidget({
    super.key,
    required this.date,
    required this.title,
    required this.content,
    required this.classBadge,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date
          Text(
            date,
            style: TextStyle(
              fontSize: AppFontSize.caption(context),
              fontWeight: AppFontWeight.medium,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.text(context),
              fontWeight: AppFontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: screenHeight * 0.006),
          // Content
          Text(
            content,
            style: TextStyle(
              fontSize: AppFontSize.caption(context),
              fontWeight: AppFontWeight.regular,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: screenHeight * 0.012),
          // Class Badge
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.025,
                vertical: screenHeight * 0.004,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: Text(
                classBadge,
                style: TextStyle(
                  fontSize: AppFontSize.overline(context),
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
