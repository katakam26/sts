import 'package:flutter/cupertino.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../models/stop_item.dart';

class StopListItemWidget extends StatelessWidget {
  final StopItem stop;
  final bool isLast;

  const StopListItemWidget({
    super.key,
    required this.stop,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : screenHeight * 0.012),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Timeline Dot & Line
          Column(
            children: [
              Container(
                width: screenWidth * 0.025,
                height: screenWidth * 0.025,
                decoration: const BoxDecoration(
                  color: AppColors.running,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: screenHeight * 0.035,
                  color: AppColors.cardBorder.withOpacity(0.5),
                ),
            ],
          ),
          SizedBox(width: screenWidth * 0.03),

          // Stop Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  stop.stopName,
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  '${stop.time} · ${stop.type} · ${stop.studentCount} students',
                  style: TextStyle(
                    fontSize: AppFontSize.caption(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Stop Type Badge (P / D)
          Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              color: AppColors.running.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stop.stopType,
                style: TextStyle(
                  fontSize: AppFontSize.caption(context),
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.running,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}