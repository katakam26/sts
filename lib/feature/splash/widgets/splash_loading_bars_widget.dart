import 'package:flutter/material.dart';

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
        ShimmerEffect.onBrand(
          child: Column(
            children: [
              _bar(width: screenWidth * 0.45, height: screenHeight * 0.011),
              SizedBox(height: screenHeight * 0.01),
              _bar(width: screenWidth * 0.28, height: screenHeight * 0.011),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.022),
        Text(
          'Getting your school ready…',
          style: TextStyle(
            fontSize: AppFontSize.caption(context),
            fontWeight: AppFontWeight.medium,
            color: Colors.white.withValues(alpha: 0.80),
          ),
        ),
      ],
    );
  }

  Widget _bar({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height),
      ),
    );
  }
}
