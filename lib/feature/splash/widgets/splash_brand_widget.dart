import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/shimmer_effect.dart';

/// Logo + school wordmark, both carrying a brand coloured shimmer sweep.
class SplashBrandWidget extends StatelessWidget {
  const SplashBrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShimmerEffect.brand(
          child: Image.asset(
            'assets/icons/app_logo.png',
            width: screenWidth * 0.6,
            height: screenHeight * 0.14,
            color: AppColors.primary,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        ShimmerEffect.brand(
          delay: const Duration(milliseconds: 250),
          child: Text(
            'School Tracking System',
            style: TextStyle(
              fontSize: AppFontSize.h4(context),
              fontWeight: AppFontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 0.4,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Text(
          'One campus. Every journey. Tracked.',
          style: TextStyle(
            fontSize: AppFontSize.text3(context),
            fontWeight: AppFontWeight.regular,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
