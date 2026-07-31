import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sts/feature/profile/widgets/profile_menu_item_widget.dart';
import 'package:sts/feature/profile/widgets/section_label_widget.dart';

import '../../../utils/app_colors.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_event.dart';
import 'icon_trailing_widget.dart';



class SystemSectionWidget extends StatelessWidget {
  const SystemSectionWidget({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final loginBloc = context.read<LoginBloc>();

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: const Text(
          'Log out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Log out',
              style: TextStyle(color: AppColors.stopped),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      // Clears secure storage and emits LoggedOutState, which sends
      // AuthWrapper back to the login screen.
      loginBloc.add(LogoutEvent());
    }
  }

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
        SizedBox(height: screenWidth * 0.025),

        // Logout
        ProfileMenuItemWidget(
          icon: Icons.logout_rounded,
          iconColor: AppColors.stopped,
          iconBgColor: AppColors.stopped.withOpacity(0.1),
          title: 'Log out',
          trailing: const IconTrailingWidget(),
          onTap: () => _confirmLogout(context),
        ),
      ],
    );
  }
}