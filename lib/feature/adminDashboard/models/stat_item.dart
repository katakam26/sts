import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

/// One headline figure in the dashboard's stats carousel.
class StatItem {
  final IconData icon;
  final Color accent;
  final String value;
  final String label;

  const StatItem({
    required this.icon,
    required this.accent,
    required this.value,
    required this.label,
  });

  static const List<StatItem> all = [
    StatItem(
      icon: Icons.directions_bus_outlined,
      accent: AppColors.fleetStatus,
      value: '35',
      label: 'Total\nBuses',
    ),
    StatItem(
      icon: Icons.people_outline,
      accent: AppColors.attendance,
      value: '2,845',
      label: 'Active\nStudents',
    ),
    StatItem(
      icon: Icons.alt_route_outlined,
      accent: AppColors.routes,
      value: '28',
      label: 'Routes',
    ),
    StatItem(
      icon: Icons.person_outline,
      accent: AppColors.liveTracking,
      value: '34',
      label: 'Drivers',
    ),
  ];
}
