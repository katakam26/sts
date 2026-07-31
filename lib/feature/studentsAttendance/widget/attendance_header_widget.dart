import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';



class AttendanceHeaderWidget extends StatelessWidget {
  const AttendanceHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: screenWidth * 0.08,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              'Student Attendance',
              style: TextStyle(
                fontSize: AppFontSize.h4(context),
                fontWeight: AppFontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        // Saved Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.015,
          ),
          decoration: BoxDecoration(
            color: AppColors.running.withOpacity(0.15),
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.running,
                size: screenWidth * 0.04,
              ),
              SizedBox(width: screenWidth * 0.015),
              Text(
                'Saved',
                style: TextStyle(
                  fontSize: AppFontSize.caption(context),
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.running,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}