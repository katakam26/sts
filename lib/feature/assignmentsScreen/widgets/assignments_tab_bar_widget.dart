import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';



class AssignmentsTabBarWidget extends StatelessWidget {
  final TabController tabController;

  const AssignmentsTabBarWidget({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(screenWidth * 0.01),
        dividerColor: Colors.transparent,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: TextStyle(
          fontSize: AppFontSize.text3(context),
          fontWeight: AppFontWeight.semiBold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: AppFontSize.text3(context),
          fontWeight: AppFontWeight.medium,
        ),
        tabs: const [
          Tab(text: 'Assignments'),
          Tab(text: 'Diary'),
          Tab(text: 'Notes'),
        ],
      ),
    );
  }
}