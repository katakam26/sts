import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';


class ProfileStatsWidget extends StatelessWidget {
  const ProfileStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          border: Border.all(
            color: AppColors.cardBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem(context, '3', 'Total Buses'),
            Container(
              width: 1,
              height: screenWidth * 0.08,
              color: AppColors.cardBorder.withOpacity(0.5),
            ),
            _buildStatItem(context, '12', 'Students'),
            Container(
              width: 1,
              height: screenWidth * 0.08,
              color: AppColors.cardBorder.withOpacity(0.5),
            ),
            _buildStatItem(context, '3', 'Routes'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: AppFontSize.h4(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Text(
          label,
          style: TextStyle(
            fontSize: AppFontSize.caption(context),
            fontWeight: AppFontWeight.regular,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}