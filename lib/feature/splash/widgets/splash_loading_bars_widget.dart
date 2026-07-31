import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/shimmer_effect.dart';

/// Skeleton bars at the foot of the splash, so the wait reads as "loading"
/// rather than "stuck".
class SplashLoadingBarsWidget extends StatelessWidget {
  const SplashLoadingBarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        ShimmerEffect(
          child: Column(
            children: [
              ShimmerBox(width: screenWidth * 0.45, height: screenHeight * 0.012),
              SizedBox(height: screenHeight * 0.01),
              ShimmerBox(width: screenWidth * 0.30, height: screenHeight * 0.012),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          'Getting your school ready…',
          style: TextStyle(
            fontSize: AppFontSize.caption(context),
            fontWeight: AppFontWeight.medium,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
