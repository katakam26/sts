import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class StudentsHeaderWidget extends StatelessWidget {
  const StudentsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: screenWidth * 0.08,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(width: screenWidth * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students',
              style: TextStyle(
                fontSize: AppFontSize.h3(context),
                fontWeight: AppFontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              '12 students',
              style: TextStyle(
                fontSize: AppFontSize.text3(context),
                fontWeight: AppFontWeight.regular,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}