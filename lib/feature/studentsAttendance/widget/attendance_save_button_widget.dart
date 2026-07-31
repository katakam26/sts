import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class AttendanceSaveButtonWidget extends StatelessWidget {
  const AttendanceSaveButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(
            color: AppColors.cardBorder.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: InkWell(
          onTap: () {
            // Save attendance logic
          },
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.018,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            child: Center(
              child: Text(
                'Save Attendance',
                style: TextStyle(
                  fontSize: AppFontSize.text(context),
                  fontWeight: AppFontWeight.semiBold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}