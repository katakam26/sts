import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../model/attendance_status.dart';



class StudentAttendanceCardWidget extends StatelessWidget {
  final StudentAttendanceItem student;
  final Function(AttendanceStatus) onStatusChanged;

  const StudentAttendanceCardWidget({
    super.key,
    required this.student,
    required this.onStatusChanged,
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
            width: screenWidth * 0.11,
            height: screenWidth * 0.11,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Center(
              child: Text(
                student.initials,
                style: TextStyle(
                  fontSize: AppFontSize.text(context),
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),

          // Student Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Student Name
                Text(
                  student.name,
                  style: TextStyle(
                    fontSize: AppFontSize.text2(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.003),
                // Admission No, Roll No, Class
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Adm No. ${student.admissionNo}',
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
                        text: 'Roll No. ${student.rollNo}',
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
                        text: student.className,
                        style: TextStyle(
                          fontSize: AppFontSize.caption(context),
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                // Parent Name
                Text(
                  student.parentName,
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: screenWidth * 0.02),

          // Attendance Status Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Present Button (P)
              _buildStatusButton(
                context,
                label: 'P',
                isSelected: student.attendanceStatus == AttendanceStatus.present,
                selectedColor: AppColors.running,
                onTap: () => onStatusChanged(AttendanceStatus.present),
              ),
              SizedBox(width: screenWidth * 0.015),
              // Absent Button (A)
              _buildStatusButton(
                context,
                label: 'A',
                isSelected: student.attendanceStatus == AttendanceStatus.absent,
                selectedColor: AppColors.stopped,
                onTap: () => onStatusChanged(AttendanceStatus.absent),
              ),
              SizedBox(width: screenWidth * 0.015),
              // Late Button (LV)
              _buildStatusButton(
                context,
                label: 'LV',
                isSelected: student.attendanceStatus == AttendanceStatus.late,
                selectedColor: AppColors.liveTracking,
                onTap: () => onStatusChanged(AttendanceStatus.late),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(
      BuildContext context, {
        required String label,
        required bool isSelected,
        required Color selectedColor,
        required VoidCallback onTap,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(screenWidth * 0.04),
      child: Container(
        width: screenWidth * 0.08,
        height: screenWidth * 0.08,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : AppColors.cardBorder.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.caption(context),
              fontWeight: AppFontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}