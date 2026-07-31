import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';


class IconTrailingWidget extends StatelessWidget {
  const IconTrailingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color: AppColors.textMuted,
      size: MediaQuery.of(context).size.width * 0.06,
    );
  }
}