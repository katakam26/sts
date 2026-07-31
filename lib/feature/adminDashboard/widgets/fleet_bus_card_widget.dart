import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';


class FleetBusCardWidget extends StatelessWidget {
  final String busId;
  final String driverName;
  final String students;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String statusLabel;

  const FleetBusCardWidget({
    super.key,
    required this.busId,
    required this.driverName,
    required this.students,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.018,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bus Icon Container
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: AppColors.fleetStatus.withOpacity(0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Center(
              child: Icon(
                Icons.directions_bus, // Custom bus icon or Icons.directions_bus
                color: AppColors.fleetStatus,
                size: screenWidth * 0.06,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.035),
          // Bus Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bus ID
                Text(
                  busId,
                  style: TextStyle(
                    fontSize: AppFontSize.text2(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                // Driver Name + Students
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: driverName,
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: ' · ',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textMuted,
                        ),
                      ),
                      TextSpan(
                        text: students,
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenHeight * 0.008,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status Dot
                Container(
                  width: screenWidth * 0.018,
                  height: screenWidth * 0.018,
                  decoration: BoxDecoration(
                    color: statusTextColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: statusTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}