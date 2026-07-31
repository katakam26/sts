import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class StudentsFilterChipsWidget extends StatefulWidget {
  const StudentsFilterChipsWidget({super.key});

  @override
  State<StudentsFilterChipsWidget> createState() => _StudentsFilterChipsWidgetState();
}

class _StudentsFilterChipsWidgetState extends State<StudentsFilterChipsWidget> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', '4A', '4B'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.025),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.cardBorder.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: AppFontSize.text3(context),
                  fontWeight: isSelected ? AppFontWeight.semiBold : AppFontWeight.medium,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}