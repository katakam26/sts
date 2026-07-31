import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/section_header_widget.dart';

import '../../../utils/app_colors.dart';
import 'fleet_bus_card_widget.dart';

class FleetStatusSectionWidget extends StatelessWidget {
  const FleetStatusSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: 'Fleet Status',
          onViewAll: () {},
        ),
        SizedBox(height: screenWidth * 0.03),
        const FleetBusCardWidget(
          busId: 'BUS-001',
          driverName: 'James Wilson',
          students: '35/40',
          status: 'Running',
          statusColor: AppColors.running,
          statusTextColor: AppColors.running,
          statusLabel: 'En Route',
        ),
        SizedBox(height: screenWidth * 0.025),
        const FleetBusCardWidget(
          busId: 'BUS-002',
          driverName: 'Robert Smith',
          students: '28/40',
          status: 'Idle',
          statusColor: AppColors.idle,
          statusTextColor: AppColors.idle,
          statusLabel: 'Parked',
        ),
        SizedBox(height: screenWidth * 0.025),
        const FleetBusCardWidget(
          busId: 'BUS-003',
          driverName: 'Michael Brown',
          students: '22/35',
          status: 'Running',
          statusColor: AppColors.running,
          statusTextColor: AppColors.running,
          statusLabel: 'En Route',
        ),
      ],
    );
  }
}