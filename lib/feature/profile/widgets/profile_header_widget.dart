import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';


class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: screenWidth * 0.08,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar Container with Shield Icon
                Container(
                  width: screenWidth * 0.22,
                  height: screenWidth * 0.22,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.verified_user,
                      color: AppColors.primary,
                      size: screenWidth * 0.1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Name
                Text(
                  'Master Admin',
                  style: TextStyle(
                    fontSize: AppFontSize.h4(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),

                // Email
                Text(
                  'admin@schooltrack.edu',
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.012),

                // Role Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  child: Text(
                    'Administrator',
                    style: TextStyle(
                      fontSize: AppFontSize.caption(context),
                      fontWeight: AppFontWeight.semiBold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
