import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import 'add_routes_bottom_sheet_widget.dart';

class RoutesHeaderWidget extends StatelessWidget {
  const RoutesHeaderWidget({super.key});


  void _showAddRoutesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddRoutesBottomSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
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
                  'Routes',
                  style: TextStyle(
                    fontSize: AppFontSize.h3(context),
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '3 routes configured',
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Add Route Button
        InkWell(
          onTap: () => _showAddRoutesBottomSheet(context),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.012,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: screenWidth * 0.045,
                ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Add Route',
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}