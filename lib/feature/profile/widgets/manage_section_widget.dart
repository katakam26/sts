import 'package:flutter/material.dart';
import 'package:sts/feature/profile/widgets/profile_menu_item_widget.dart';
import 'package:sts/feature/profile/widgets/section_label_widget.dart';
import 'package:sts/feature/profile/widgets/text_trailing_widget.dart';

import '../../../utils/app_colors.dart';
import 'icon_trailing_widget.dart';


class ManageSectionWidget extends StatelessWidget {
  const ManageSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabelWidget(label: 'MANAGE'),
        SizedBox(height: screenWidth * 0.01),

        // Manage Users
        ProfileMenuItemWidget(
          icon: Icons.people_outline,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          title: 'Manage Users',
          trailing: const IconTrailingWidget(),
          onTap: () {},
        ),
        SizedBox(height: screenWidth * 0.025),

        // Bus Settings
        ProfileMenuItemWidget(
          icon: Icons.directions_bus_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          title: 'Bus Settings',
          trailing: const IconTrailingWidget(),
          onTap: () {},
        ),
        SizedBox(height: screenWidth * 0.025),

        // Notifications
        ProfileMenuItemWidget(
          icon: Icons.notifications_outlined,
          iconColor: AppColors.primary,
          iconBgColor: AppColors.primary.withOpacity(0.1),
          title: 'Notifications',
          trailing: const TextTrailingWidget(text: 'On'),
          onTap: () {},
        ),
      ],
    );
  }
}