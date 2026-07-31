import 'package:flutter/material.dart';
import 'package:sts/feature/profile/widgets/manage_section_widget.dart';
import 'package:sts/feature/profile/widgets/profile_header_widget.dart';
import 'package:sts/feature/profile/widgets/profile_stats_widget.dart';
import 'package:sts/feature/profile/widgets/system_section_widget.dart';

import '../../utils/app_colors.dart';

// ==================== PROFILE SCREEN ====================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header with Avatar
            const ProfileHeaderWidget(),

            SizedBox(height: screenHeight * 0.03),

            // Stats Row
            const ProfileStatsWidget(),

            SizedBox(height: screenHeight * 0.03),

            // Manage Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: const ManageSectionWidget(),
            ),

            SizedBox(height: screenHeight * 0.025),

            // System Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: const SystemSectionWidget(),
            ),

            SizedBox(height: screenHeight * 0.12), // Added space for bottom nav
          ],
        ),
      ),
    );
  }
}
