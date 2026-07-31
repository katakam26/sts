import 'package:flutter/material.dart';
import 'package:sts/feature/routes/widgets/stop_list_Item_widget.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../models/stop_item.dart';

class RouteCardWidget extends StatelessWidget {
  final String routeName;
  final String busId;
  final int stopsCount;
  final String distance;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<StopItem> stops;
  final VoidCallback onAddStop;

  const RouteCardWidget({
    super.key,
    required this.routeName,
    required this.busId,
    required this.stopsCount,
    required this.distance,
    required this.isExpanded,
    required this.onTap,
    required this.stops,
    required this.onAddStop,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(
          color: AppColors.cardBorder.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Route Header (Always visible)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.035),
              topRight: Radius.circular(screenWidth * 0.035),
              bottomLeft: Radius.circular(isExpanded ? 0 : screenWidth * 0.035),
              bottomRight: Radius.circular(isExpanded ? 0 : screenWidth * 0.035),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.018,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Route Icon
                  Container(
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        color: AppColors.primary,
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.035),
                  // Route Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          routeName,
                          style: TextStyle(
                            fontSize: AppFontSize.text2(context),
                            fontWeight: AppFontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.004),
                        Text(
                          '$busId · $stopsCount stops · $distance',
                          style: TextStyle(
                            fontSize: AppFontSize.caption(context),
                            fontWeight: AppFontWeight.regular,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expand/Collapse Icon
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content (Stops List)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildExpandedContent(context),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        bottom: screenHeight * 0.018,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
          Divider(
            color: AppColors.cardBorder.withOpacity(0.5),
            height: 1,
          ),
          SizedBox(height: screenHeight * 0.015),

          // STOPS Label
          Text(
            'STOPS',
            style: TextStyle(
              fontSize: AppFontSize.overline(context),
              fontWeight: AppFontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: screenHeight * 0.012),

          // Stops List
          ...stops.asMap().entries.map((entry) {
            final index = entry.key;
            final stop = entry.value;
            final isLast = index == stops.length - 1;
            return StopListItemWidget(
              stop: stop,
              isLast: isLast,
            );
          }),

          SizedBox(height: screenHeight * 0.015),

          // Add Stop Button
          InkWell(
            onTap: onAddStop,
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_location_alt_outlined,
                    color: AppColors.primary,
                    size: screenWidth * 0.045,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Add Stop',
                    style: TextStyle(
                      fontSize: AppFontSize.text3(context),
                      fontWeight: AppFontWeight.semiBold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
