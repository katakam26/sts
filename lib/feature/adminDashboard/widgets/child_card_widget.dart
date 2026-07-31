import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class ChildCardWidget extends StatelessWidget {
  final String name;
  final String className;
  final String rollNumber;
  final String attendance;
  final String grade;
  final String busId;
  final String eta;

  const ChildCardWidget({
    super.key,
    required this.name,
    required this.className,
    required this.rollNumber,
    required this.attendance,
    required this.grade,
    required this.busId,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
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
          // Avatar Container
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            child: Center(
              child: Text(
                name.split(' ').map((e) => e[0]).join(''),
                style: TextStyle(
                  fontSize: AppFontSize.h6(context),
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.035),
          // Child Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                Text(
                  name,
                  style: TextStyle(
                    fontSize: AppFontSize.text2(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                // Class and Roll
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: className,
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: ' - Roll $rollNumber',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                // Attendance and Grade Row
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.003,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Text(
                        '$attendance% Att.',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context) * 0.9,
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.025),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.003,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.amber,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            'Grade $grade',
                            style: TextStyle(
                              fontSize: AppFontSize.caption(context) * 0.9,
                              fontWeight: AppFontWeight.medium,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bus and ETA Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.004,
                ),
                decoration: BoxDecoration(
                  color: AppColors.fleetStatus.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Text(
                  busId,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context) * 0.85,
                    fontWeight: AppFontWeight.medium,
                    color: AppColors.fleetStatus,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.004),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: screenWidth * 0.035,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    'ETA $eta',
                    style: TextStyle(
                      fontSize: AppFontSize.caption(context) * 0.9,
                      fontWeight: AppFontWeight.medium,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}