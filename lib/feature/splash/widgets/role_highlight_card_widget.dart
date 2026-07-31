import 'package:flutter/material.dart';

import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/shimmer_effect.dart';
import '../models/splash_role.dart';

/// A single audience card (Students / Teachers / Drivers). Frosted glass over
/// the brand gradient: it slides up into place, then keeps a white shimmer
/// running across its illustrative icon tile.
class RoleHighlightCardWidget extends StatelessWidget {
  final SplashRole role;
  final Animation<double> animation;
  final Duration shimmerDelay;

  const RoleHighlightCardWidget({
    super.key,
    required this.role,
    required this.animation,
    this.shimmerDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.35),
          end: Offset.zero,
        ).animate(animation),
        child: Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.014),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.016,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(screenWidth * 0.045),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: Row(
            children: [
              ShimmerEffect.onBrand(
                delay: shimmerDelay,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(screenWidth * 0.035),
                  ),
                  child: Icon(
                    role.icon,
                    color: Colors.white,
                    size: screenWidth * 0.065,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.title,
                      style: TextStyle(
                        fontSize: AppFontSize.h6(context),
                        fontWeight: AppFontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    Text(
                      role.subtitle,
                      style: TextStyle(
                        fontSize: AppFontSize.caption(context),
                        fontWeight: AppFontWeight.regular,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
