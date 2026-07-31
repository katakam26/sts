import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/section_header_widget.dart';
import 'package:sts/feature/admindashboard/widgets/vehicle_status_card_widget.dart';

import '../../../utils/app_colors.dart';

class VehicleStatusSectionWidget extends StatelessWidget {
  const VehicleStatusSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: 'Vehicle Status',
          onViewAll: () {},
        ),
        SizedBox(height: screenWidth * 0.03),
        Row(
          children: [
            Expanded(
              child: VehicleStatusCardWidget(
                icon: Icons.play_circle_filled,
                iconColor: AppColors.running,
                iconBgColor: AppColors.running.withOpacity(0.1),
                count: '24',
                label: 'Running',
                waveColor: AppColors.running.withOpacity(0.1),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: VehicleStatusCardWidget(
                icon: Icons.access_time,
                iconColor: AppColors.idle,
                iconBgColor: AppColors.idle.withOpacity(0.1),
                count: '4',
                label: 'Idle',
                waveColor: AppColors.idle.withOpacity(0.1),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: VehicleStatusCardWidget(
                icon: Icons.stop,
                iconColor: AppColors.stopped,
                iconBgColor: AppColors.stopped.withOpacity(0.1),
                count: '2',
                label: 'Stopped',
                waveColor: AppColors.stopped.withOpacity(0.1),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: VehicleStatusCardWidget(
                icon: Icons.power_settings_new,
                iconColor: AppColors.inactive,
                iconBgColor: AppColors.inactive.withOpacity(0.1),
                count: '1',
                label: 'Inactive',
                waveColor: AppColors.inactive.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
