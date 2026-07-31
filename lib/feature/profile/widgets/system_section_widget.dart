import 'package:flutter/material.dart';
import 'package:sts/feature/profile/widgets/profile_menu_item_widget.dart';
import 'package:sts/feature/profile/widgets/section_label_widget.dart';

import '../../../utils/app_colors.dart';
import 'icon_trailing_widget.dart';



class SystemSectionWidget extends StatelessWidget {
  const SystemSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabelWidget(label: 'SYSTEM'),
        SizedBox(height: screenWidth * 0.01),

        // Reports & Analytics
        ProfileMenuItemWidget(
          icon: Icons.bar_chart_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          title: 'Reports & Analytics',
          trailing: const IconTrailingWidget(),
          onTap: () {},
        ),
        SizedBox(height: screenWidth * 0.025),

        // System Settings
        ProfileMenuItemWidget(
          icon: Icons.settings_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          title: 'System Settings',
          trailing: const IconTrailingWidget(),
          onTap: () {},
        ),
      ],
    );
  }
}