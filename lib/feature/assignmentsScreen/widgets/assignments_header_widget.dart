import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class AssignmentsHeaderWidget extends StatelessWidget {
  const AssignmentsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Assignments',
          style: TextStyle(
            fontSize: AppFontSize.h4(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        // Add Button
        Container(
          width: screenWidth * 0.1,
          height: screenWidth * 0.1,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: screenWidth * 0.05,
            ),
          ),
        ),
      ],
    );
  }
}