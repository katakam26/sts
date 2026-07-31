import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class QuickActionCardWidget extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String label;
  final VoidCallback? onTap;

  const QuickActionCardWidget({
    super.key,
    required this.icon,
    required this.accent,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.08),
              blurRadius: screenWidth * 0.035,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustrative icon tile: soft accent gradient behind a rounded glyph.
            Container(
              padding: EdgeInsets.all(screenWidth * 0.028),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withValues(alpha: 0.22),
                    accent.withValues(alpha: 0.07),
                  ],
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                border: Border.all(color: accent.withValues(alpha: 0.18)),
              ),
              child: Icon(
                icon,
                color: accent,
                size: screenWidth * 0.062,
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Text(
              label,
              style: TextStyle(
                fontSize: AppFontSize.caption(context),
                fontWeight: AppFontWeight.medium,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
