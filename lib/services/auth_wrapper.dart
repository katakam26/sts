// lib/features/auth/pages/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feature/login/bloc/login_bloc.dart';
import '../feature/login/bloc/login_event.dart';
import '../feature/login/bloc/login_state.dart';
import '../feature/login/view/login_screen.dart';
import '../feature/navigation/bottom_nav.dart';
import '../utils/app_colors.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Check login status when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LoginBloc>().add(CheckLoginStatusEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        // Only rebuild AuthWrapper when the core login status changes
        return current is LoggedInState || current is LoggedOutState || current is LoginInitial;
      },
      builder: (context, state) {
        if (state is LoggedInState) {
          // User is logged in, go to main screen
          return const MainBottomNav();
        } else if (state is LoginInitial) {
          // Show loading while checking login status
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        } else {
          // For all other states (LoggedOut, LoginLoading, OTPSent, LoginError),
          // show the Login Flow (starting with VerifyMobileScreen).
          return const VerifyMobileScreen();
        }
      },
    );
  }
}