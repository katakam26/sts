import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';


class AttendanceSummaryChipsWidget extends StatelessWidget {
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int unmarkedCount;

  const AttendanceSummaryChipsWidget({
    super.key,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.unmarkedCount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        _buildChip(
          context,
          count: presentCount,
          label: 'Present',
          countColor: AppColors.running,
          bgColor: AppColors.running.withOpacity(0.1),
        ),
        SizedBox(width: screenWidth * 0.025),
        _buildChip(
          context,
          count: absentCount,
          label: 'Absent',
          countColor: AppColors.stopped,
          bgColor: AppColors.stopped.withOpacity(0.1),
        ),
        SizedBox(width: screenWidth * 0.025),
        _buildChip(
          context,
          count: lateCount,
          label: 'Late',
          countColor: AppColors.liveTracking,
          bgColor: AppColors.liveTracking.withOpacity(0.1),
        ),
        SizedBox(width: screenWidth * 0.025),
        _buildChip(
          context,
          count: unmarkedCount,
          label: 'Unmarked',
          countColor: AppColors.textSecondary,
          bgColor: AppColors.cardBorder.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildChip(
      BuildContext context, {
        required int count,
        required String label,
        required Color countColor,
        required Color bgColor,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.012,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: AppFontSize.h5(context),
                fontWeight: AppFontWeight.bold,
                color: countColor,
              ),
            ),
            SizedBox(width: screenWidth * 0.015),
            Text(
              label,
              style: TextStyle(
                fontSize: AppFontSize.caption(context),
                fontWeight: AppFontWeight.medium,
                color: countColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}