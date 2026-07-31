import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

/// One tile in the dashboard's Quick Actions grid.
class QuickActionItem {
  final IconData icon;
  final String label;
  final Color accent;

  const QuickActionItem({
    required this.icon,
    required this.label,
    required this.accent,
  });

  static const List<QuickActionItem> all = [
    QuickActionItem(
      icon: Icons.my_location_rounded,
      label: 'Live Tracking',
      accent: AppColors.liveTracking,
    ),
    QuickActionItem(
      icon: Icons.airport_shuttle_rounded,
      label: 'Fleet Status',
      accent: AppColors.fleetStatus,
    ),
    QuickActionItem(
      icon: Icons.groups_rounded,
      label: 'Students',
      accent: AppColors.students,
    ),
    QuickActionItem(
      icon: Icons.fact_check_rounded,
      label: 'Attendance',
      accent: AppColors.attendance,
    ),
    QuickActionItem(
      icon: Icons.route_rounded,
      label: 'Routes',
      accent: AppColors.routes,
    ),
    QuickActionItem(
      icon: Icons.badge_rounded,
      label: 'Drivers',
      accent: AppColors.drivers,
    ),
    QuickActionItem(
      icon: Icons.campaign_rounded,
      label: 'Notices',
      accent: AppColors.notices,
    ),
    QuickActionItem(
      icon: Icons.auto_stories_rounded,
      label: 'Homework',
      accent: AppColors.homework,
    ),
    QuickActionItem(
      icon: Icons.insights_rounded,
      label: 'Reports',
      accent: AppColors.reports,
    ),
    QuickActionItem(
      icon: Icons.event_available_rounded,
      label: 'Schedule',
      accent: AppColors.schedule,
    ),
    QuickActionItem(
      icon: Icons.sms_rounded,
      label: 'Send SMS',
      accent: AppColors.sendSMS,
    ),
    QuickActionItem(
      icon: Icons.tune_rounded,
      label: 'Settings',
      accent: AppColors.settings,
    ),
  ];
}
