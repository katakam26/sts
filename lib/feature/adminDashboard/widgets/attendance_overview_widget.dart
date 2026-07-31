import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';



class AttendanceOverviewWidget extends StatelessWidget {
  const AttendanceOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          // Circular Progress
          SizedBox(
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: screenWidth * 0.015,
                  backgroundColor: AppColors.cardBorder,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.running),
                ),
                Center(
                  child: Text(
                    '92%',
                    style: TextStyle(
                      fontSize: AppFontSize.h5(context),
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance Overview',
                  style: TextStyle(
                    fontSize: AppFontSize.text(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  "Today's Attendance",
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  child: LinearProgressIndicator(
                    value: 0.92,
                    minHeight: screenHeight * 0.008,
                    backgroundColor: AppColors.cardBorder,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.running),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '2,530 / 2,750',
                style: TextStyle(
                  fontSize: AppFontSize.text3(context),
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.running,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
                size: screenWidth * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }
}