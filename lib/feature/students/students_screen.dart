import 'package:flutter/material.dart';
import 'package:sts/feature/students/widgets/students_filter_chips_widget.dart';
import 'package:sts/feature/students/widgets/students_header_widget.dart';
import 'package:sts/feature/students/widgets/students_list_widget.dart';
import 'package:sts/feature/students/widgets/students_search_bar_widget.dart';

import '../../utils/app_colors.dart';

// ==================== STUDENTS SCREEN ====================
class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

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
              const StudentsHeaderWidget(),

                SizedBox(height: screenHeight * 0.02),

                // Search Bar
                const StudentsSearchBarWidget(),

                SizedBox(height: screenHeight * 0.02),

                // Filter Chips
                const StudentsFilterChipsWidget(),

                SizedBox(height: screenHeight * 0.02),

                // Student List
                const StudentsListWidget(),

                SizedBox(height: screenHeight * 0.12), // Added space for bottom nav
              ],
            ),
          ),
        ),
    );
  }
}
