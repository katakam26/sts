import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/shimmer_effect.dart';
import '../models/splash_role.dart';

/// A single audience card (Students / Teachers / Drivers) that slides up into
/// place, then keeps a soft shimmer running across its illustrative icon tile.
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
          margin: EdgeInsets.only(bottom: screenHeight * 0.016),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.018,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(screenWidth * 0.045),
            border: Border.all(color: AppColors.cardBorder),
            boxShadow: [
              BoxShadow(
                color: role.accent.withValues(alpha: 0.10),
                blurRadius: screenWidth * 0.05,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              ShimmerEffect(
                baseColor: role.accent,
                highlightColor: Colors.white,
                delay: shimmerDelay,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.032),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        role.accent.withValues(alpha: 0.20),
                        role.accent.withValues(alpha: 0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.035),
                  ),
                  child: Icon(
                    role.icon,
                    color: role.accent,
                    size: screenWidth * 0.07,
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
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    Text(
                      role.subtitle,
                      style: TextStyle(
                        fontSize: AppFontSize.caption(context),
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.textSecondary,
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
