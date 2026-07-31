import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/quick_action_card_widget.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class QuickActionsSectionWidget extends StatelessWidget {
  const QuickActionsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: AppFontSize.h5(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        // Row 1
        Row(
          children: [
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.location_on,
                iconColor: AppColors.liveTracking,
                iconBgColor: AppColors.liveTracking.withOpacity(0.1),
                label: 'Live Tracking',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.directions_bus,
                iconColor: AppColors.fleetStatus,
                iconBgColor: AppColors.fleetStatus.withOpacity(0.1),
                label: 'Fleet Status',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.people,
                iconColor: AppColors.students,
                iconBgColor: AppColors.students.withOpacity(0.1),
                label: 'Students',
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.025),
        // Row 2
        Row(
          children: [
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.check_circle,
                iconColor: AppColors.attendance,
                iconBgColor: AppColors.attendance.withOpacity(0.1),
                label: 'Attendance',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.alt_route,
                iconColor: AppColors.routes,
                iconBgColor: AppColors.routes.withOpacity(0.1),
                label: 'Routes',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.person,
                iconColor: AppColors.drivers,
                iconBgColor: AppColors.drivers.withOpacity(0.1),
                label: 'Drivers',
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.025),
        // Row 3
        Row(
          children: [
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.campaign,
                iconColor: AppColors.notices,
                iconBgColor: AppColors.notices.withOpacity(0.1),
                label: 'Notices',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.menu_book,
                iconColor: AppColors.homework,
                iconBgColor: AppColors.homework.withOpacity(0.1),
                label: 'Homework',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.bar_chart,
                iconColor: AppColors.reports,
                iconBgColor: AppColors.reports.withOpacity(0.1),
                label: 'Reports',
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.025),
        // Row 4
        Row(
          children: [
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.calendar_today,
                iconColor: AppColors.schedule,
                iconBgColor: AppColors.schedule.withOpacity(0.1),
                label: 'Schedule',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.chat_bubble,
                iconColor: AppColors.sendSMS,
                iconBgColor: AppColors.sendSMS.withOpacity(0.1),
                label: 'Send SMS',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: QuickActionCardWidget(
                icon: Icons.settings,
                iconColor: AppColors.settings,
                iconBgColor: AppColors.settings.withOpacity(0.1),
                label: 'Settings',
              ),
            ),
          ],
        ),
      ],
    );
  }
}