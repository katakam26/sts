import 'package:flutter/cupertino.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';


class VehicleStatusCardWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String count;
  final String label;
  final Color waveColor;

  const VehicleStatusCardWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.count,
    required this.label,
    required this.waveColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: screenWidth * 0.05,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            count,
            style: TextStyle(
              fontSize: AppFontSize.h5(context),
              fontWeight: AppFontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: screenHeight * 0.003),
          Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.overline(context),
              fontWeight: AppFontWeight.medium,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}