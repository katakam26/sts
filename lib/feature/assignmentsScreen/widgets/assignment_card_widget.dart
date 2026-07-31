import 'package:flutter/cupertino.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class AssignmentCardWidget extends StatelessWidget {
  final String subject;
  final Color subjectColor;
  final Color subjectBgColor;
  final String dueDate;
  final String title;
  final String description;
  final String addedDate;
  final String classBadge;

  const AssignmentCardWidget({
    super.key,
    required this.subject,
    required this.subjectColor,
    required this.subjectBgColor,
    required this.dueDate,
    required this.title,
    required this.description,
    required this.addedDate,
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
          color: AppColors.cardBorder.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Subject + Due Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subject Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.006,
                ),
                decoration: BoxDecoration(
                  color: subjectBgColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Text(
                  subject,
                  style: TextStyle(
                    fontSize: AppFontSize.overline(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: subjectColor,
                  ),
                ),
              ),
              // Due Date
              Text(
                dueDate,
                style: TextStyle(
                  fontSize: AppFontSize.caption(context),
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.012),
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
          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: AppFontSize.caption(context),
              fontWeight: AppFontWeight.regular,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: screenHeight * 0.012),
          // Bottom Row: Added Date + Class Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                addedDate,
                style: TextStyle(
                  fontSize: AppFontSize.overline(context),
                  fontWeight: AppFontWeight.regular,
                  color: AppColors.textMuted,
                ),
              ),
              // Class Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.004,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
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
            ],
          ),
        ],
      ),
    );
  }
}