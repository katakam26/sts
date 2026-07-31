import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/section_header_widget.dart';
import 'package:sts/feature/admindashboard/widgets/student_stat_card_widget.dart';

import '../../../utils/app_colors.dart';

class StudentStatisticsSectionWidget extends StatelessWidget {
  const StudentStatisticsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: 'Student Statistics',
          onViewAll: () {},
        ),
        SizedBox(height: screenWidth * 0.03),
        Row(
          children: [
            Expanded(
              child: StudentStatCardWidget(
                icon: Icons.people,
                iconColor: AppColors.attendance,
                iconBgColor: AppColors.attendance.withOpacity(0.1),
                value: '2,530',
                label: 'Present',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: StudentStatCardWidget(
                icon: Icons.person_remove,
                iconColor: AppColors.stopped,
                iconBgColor: AppColors.stopped.withOpacity(0.1),
                value: '120',
                label: 'Absent',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: StudentStatCardWidget(
                icon: Icons.event_note,
                iconColor: AppColors.idle,
                iconBgColor: AppColors.idle.withOpacity(0.1),
                value: '36',
                label: 'On Leave',
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: StudentStatCardWidget(
                icon: Icons.directions_bus,
                iconColor: AppColors.liveTracking,
                iconBgColor: AppColors.liveTracking.withOpacity(0.1),
                value: '159',
                label: 'In Transit',
              ),
            ),
          ],
        ),
      ],
    );
  }
}