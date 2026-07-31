import 'package:flutter/cupertino.dart';
import '../utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/app_logo.png',
          width: width * 0.85,
          height: height * 0.2,
          color: AppColors.primary,
        ),
      ],
    );
  }
}