import 'package:flutter/material.dart';
import 'package:sts/feature/adminDashboard/widgets/attendance_overview_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/fleet_monitoring_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/fleet_status_section_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/my_children_section_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/quick_actions_section_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/sdmin_feader_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/stats_carousel_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/student_statistics_section_widget.dart';
import 'package:sts/feature/adminDashboard/widgets/vehicle_status_section_widget.dart';

import '../../utils/app_colors.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

            // Header
            const AdminHeaderWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Stats Carousel
              const StatsCarouselWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Fleet Monitoring Card
              const FleetMonitoringWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Vehicle Status Section
              const VehicleStatusSectionWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Student Statistics Section
              const StudentStatisticsSectionWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Attendance Overview
              const AttendanceOverviewWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Quick Actions (3 in a row)
              const QuickActionsSectionWidget(),

              SizedBox(height: screenHeight * 0.025),

              // Fleet Status List
              const FleetStatusSectionWidget(),

              SizedBox(height: screenHeight * 0.025),

              //My Children List
            const MyChildrenSectionWidget(),
            SizedBox(height: screenHeight * 0.12),
          ],
        ),
      ),
    ),
  );
}
}
