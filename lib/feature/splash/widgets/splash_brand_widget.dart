import 'package:flutter/material.dart';

import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/shimmer_effect.dart';

/// Logo + school wordmark in white, carrying a white shimmer sweep across the
/// brand gradient behind them.
class SplashBrandWidget extends StatelessWidget {
  const SplashBrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Halo disc lifts the white logo off the orange field.
        Container(
          padding: EdgeInsets.all(screenWidth * 0.06),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: screenWidth * 0.08,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ShimmerEffect.onBrand(
            child: Image.asset(
              'assets/icons/app_logo.png',
              width: screenWidth * 0.40,
              height: screenHeight * 0.10,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        ShimmerEffect.onBrand(
          delay: const Duration(milliseconds: 300),
          child: Text(
            'School Tracking System',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppFontSize.h3(context),
              fontWeight: AppFontWeight.extraBold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.012),
        Text(
          'One campus. Every journey. Tracked.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppFontSize.text3(context),
            fontWeight: AppFontWeight.medium,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}
