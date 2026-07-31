import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

/// One of the three audiences the school app is built for.
class SplashRole {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const SplashRole({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  static const List<SplashRole> all = [
    SplashRole(
      icon: Icons.school_rounded,
      title: 'Students',
      subtitle: 'Attendance, homework & bus updates',
      accent: AppColors.students,
    ),
    SplashRole(
      icon: Icons.cast_for_education_rounded,
      title: 'Teachers',
      subtitle: 'Classes, diary notes & reports',
      accent: AppColors.liveTracking,
    ),
    SplashRole(
      icon: Icons.airport_shuttle_rounded,
      title: 'Drivers',
      subtitle: 'Routes, stops & live tracking',
      accent: AppColors.fleetStatus,
    ),
  ];
}
