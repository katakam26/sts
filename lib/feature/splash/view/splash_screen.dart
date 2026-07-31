import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/auth_wrapper.dart';
import '../../../utils/app_colors.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../models/splash_role.dart';
import '../widgets/role_highlight_card_widget.dart';
import '../widgets/splash_brand_widget.dart';
import '../widgets/splash_loading_bars_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _revealController;
  late final List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Staggered reveal: each role card starts a beat after the previous one.
    _cardAnimations = List.generate(SplashRole.all.length, (index) {
      final start = 0.15 * index;
      return CurvedAnimation(
        parent: _revealController,
        curve: Interval(start, start + 0.55, curve: Curves.easeOutCubic),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _revealController.forward();
      context.read<SplashBloc>().add(StartSplashEvent());
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, __, ___) => const AuthWrapper(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) => current is SplashCompleted,
      listener: (context, state) => _goToAuth(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GestureDetector(
          // Tapping anywhere skips the rest of the intro.
          onTap: () => context.read<SplashBloc>().add(SkipSplashEvent()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  AppColors.background,
                  Color(0xFFFFF1EA), // warm tint of AppColors.primary
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Decorative brand blobs behind the content.
                Positioned(
                  top: -screenHeight * 0.08,
                  right: -screenWidth * 0.18,
                  child: _BrandBlob(
                    size: screenWidth * 0.6,
                    color: AppColors.primary.withValues(alpha: 0.10),
                  ),
                ),
                Positioned(
                  bottom: -screenHeight * 0.05,
                  left: -screenWidth * 0.22,
                  child: _BrandBlob(
                    size: screenWidth * 0.55,
                    color: AppColors.secondary.withValues(alpha: 0.45),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    // Keeps the Spacer working on tall screens while degrading
                    // to a scroll instead of an overflow on short ones.
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight * 0.09),
                                  const SplashBrandWidget(),
                                  SizedBox(height: screenHeight * 0.05),
                                  for (var i = 0;
                                      i < SplashRole.all.length;
                                      i++)
                                    RoleHighlightCardWidget(
                                      role: SplashRole.all[i],
                                      animation: _cardAnimations[i],
                                      shimmerDelay:
                                          Duration(milliseconds: 200 * i),
                                    ),
                                  const Spacer(),
                                  const SplashLoadingBarsWidget(),
                                  SizedBox(height: screenHeight * 0.04),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _BrandBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
