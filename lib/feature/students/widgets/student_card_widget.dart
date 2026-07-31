import 'package:flutter/cupertino.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class StudentCardWidget extends StatelessWidget {
  final String initials;
  final Color initialsColor;
  final Color initialsBgColor;
  final String name;
  final String admissionNo;
  final String rollNo;
  final String parentName;
  final String grade;
  final Color gradeColor;
  final Color gradeBgColor;
  final String percentage;
  final Color percentageColor;
  final Color percentageBgColor;

  const StudentCardWidget({
    super.key,
    required this.initials,
    required this.initialsColor,
    required this.initialsBgColor,
    required this.name,
    required this.admissionNo,
    required this.rollNo,
    required this.parentName,
    required this.grade,
    required this.gradeColor,
    required this.gradeBgColor,
    required this.percentage,
    required this.percentageColor,
    required this.percentageBgColor,
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
          // Initials Avatar
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: initialsBgColor,
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: AppFontSize.text(context),
                  fontWeight: AppFontWeight.bold,
                  color: initialsColor,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.035),
          // Student Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Student Name
                Text(
                  name,
                  style: TextStyle(
                    fontSize: AppFontSize.text2(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                // Admission No & Roll No
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Adm No. $admissionNo',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textMuted,
                        ),
                      ),
                      TextSpan(
                        text: 'Roll No. $rollNo',
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.003),
                // Parent Name
                Text(
                  parentName,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          // Right Side: Grade & Percentage
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grade Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.004,
                ),
                decoration: BoxDecoration(
                  color: gradeBgColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.015),
                ),
                child: Text(
                  grade,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.bold,
                    color: gradeColor,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.008),
              // Percentage Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.004,
                ),
                decoration: BoxDecoration(
                  color: percentageBgColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.015),
                ),
                child: Text(
                  percentage,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: percentageColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}