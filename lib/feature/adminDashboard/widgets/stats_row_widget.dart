import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/stat_card_widget.dart';

import '../../../utils/app_colors.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            icon: Icons.directions_bus_outlined,
            iconColor: AppColors.fleetStatus,
            iconBgColor: AppColors.fleetStatus.withOpacity(0.1),
            value: '35',
            label: 'Total Buses',
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        Expanded(
          child: StatCardWidget(
            icon: Icons.people_outline,
            iconColor: AppColors.attendance,
            iconBgColor: AppColors.attendance.withOpacity(0.1),
            value: '2,845',
            label: 'Active\nStudents',
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        Expanded(
          child: StatCardWidget(
            icon: Icons.alt_route_outlined,
            iconColor: AppColors.routes,
            iconBgColor: AppColors.routes.withOpacity(0.1),
            value: '28',
            label: 'Routes',
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        Expanded(
          child: StatCardWidget(
            icon: Icons.person_outline,
            iconColor: AppColors.liveTracking,
            iconBgColor: AppColors.liveTracking.withOpacity(0.1),
            value: '34',
            label: 'Drivers',
          ),
        ),
      ],
    );
  }
}
