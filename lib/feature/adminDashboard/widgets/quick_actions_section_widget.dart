import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../models/quick_action_item.dart';
import 'quick_action_card_widget.dart';

class QuickActionsSectionWidget extends StatelessWidget {
  static const int _columns = 3;

  const QuickActionsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double gap = screenWidth * 0.025;
    final items = QuickActionItem.all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: AppFontSize.h5(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        for (var start = 0; start < items.length; start += _columns) ...[
          if (start > 0) SizedBox(height: gap),
          Row(
            children: [
              for (var i = start; i < start + _columns; i++) ...[
                if (i > start) SizedBox(width: gap),
                Expanded(
                  child: i < items.length
                      ? QuickActionCardWidget(
                          icon: items[i].icon,
                          accent: items[i].accent,
                          label: items[i].label,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
