import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import '../adminDashboard/admin_dashboard.dart';
import '../routes/routes_screen.dart';
import '../students/students_screen.dart';
import '../studentsAttendance/student_attendance_screen.dart';
import '../profile/profile_screen.dart';
import '../../utils/app_colors.dart';

import '../../widgets/app_sidebar.dart';

class MainBottomNav extends StatefulWidget {
  final int initialIndex;
  const MainBottomNav({super.key, this.initialIndex = 0});
  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  // ── Carousel paging between tabs ───────────────────────────────
  late final PageController _pageController;
  static const Duration _pageSlideDuration = Duration(milliseconds: 350);

  // ── Nav bar visibility ─────────────────────────────────────────
  late AnimationController _navBarAnimController;
  late Animation<Offset> _navBarSlide;
  bool _isNavBarVisible = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _buildScreens();
    _pageController = PageController(initialPage: _currentIndex);

    _navBarAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _navBarSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2.5),
    ).animate(CurvedAnimation(
      parent: _navBarAnimController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Screen initialization logic if needed
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarAnimController.dispose();
    super.dispose();
  }

  void _hideNavBar() {
    if (_isNavBarVisible) {
      _isNavBarVisible = false;
      _navBarAnimController.forward();
    }
  }

  void _showNavBar() {
    if (!_isNavBarVisible) {
      _isNavBarVisible = true;
      _navBarAnimController.reverse();
    }
  }

  // ─── Named navigation functions ──────────────────────────────────
  void goToDashboard() => _onItemTapped(0);
  void goToRoutes() => _onItemTapped(1);
  void goToStudents() => _onItemTapped(2);
  void goToAttendance() => _onItemTapped(3);
  void goToProfile() => _onItemTapped(4);
  // ─────────────────────────────────────────────────────────────────

  void _onItemTapped(int index) {
    // Always show nav bar when tapping a tab
    _showNavBar();

    if (index == _currentIndex) return;

    // Slide across to the tab instead of swapping it in instantly.
    _pageController.animateToPage(
      index,
      duration: _pageSlideDuration,
      curve: Curves.easeInOut,
    );
  }

  // Fired by both a tab tap and a manual swipe.
  void _onPageChanged(int index) {
    _showNavBar();
    setState(() => _currentIndex = index);
  }

  late List<Widget> _screens;

  void _buildScreens() {
    _screens = [
      const AdminDashboardScreen(),
      const RoutesScreen(),
      const StudentsScreen(),
      const StudentAttendanceScreen(),
      const ProfileScreen(),
    ];
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      _onItemTapped(0);
      return false;
    }
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
        title: const Text('Exit App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No',
                style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: const Text('Yes',
                style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    )) ??
        false;
  }

  Widget _buildFloatingNavItem({
    required String iconPath,
    required int index,
    required bool isCenter,
    required double iconSize,
    required double centerIconSize,
  }) {
    final bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCenter ? iconSize * 0.3 : iconSize * 0.5,
          vertical: iconSize * 0.3,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: SvgPicture.asset(
          iconPath,
          width: isCenter ? centerIconSize : iconSize,
          height: isCenter ? centerIconSize : iconSize,
          colorFilter: ColorFilter.mode(
            isActive ? AppColors.primary : Colors.grey.shade600,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    final double horizontalMargin = screenWidth * 0.05;
    final double verticalMargin = screenHeight * 0.02;
    final double navBarHeight =
    isTablet ? screenHeight * 0.08 : screenHeight * 0.075;
    final double borderRadius = navBarHeight / 2;
    final double iconSize = screenWidth * 0.055;
    final double centerIconSize = screenWidth * 0.07;
    final double shadowBlur = screenWidth * 0.03;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (_currentIndex != 0) {
          _onItemTapped(0);
          return;
        }
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            title: const Text('Exit App',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',
                    style: TextStyle(color: AppColors.primary)),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes',
                    style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
        );
        if (shouldExit == true) {
          exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        drawer: const AppSidebar(),
        body: Stack(
          children: [
            // ── NotificationListener intercepts ALL scroll events from
            //    any child screen without passing anything to them ──────
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // Ignore the PageView's own horizontal scrolls, otherwise
                // swiping between tabs would toggle the nav bar.
                if (notification is UserScrollNotification &&
                    notification.metrics.axis == Axis.vertical) {
                  final direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    _hideNavBar(); // scrolling down → hide
                  } else if (direction == ScrollDirection.forward) {
                    _showNavBar(); // scrolling up → show
                  }
                }
                return false; // don't absorb the notification
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                itemCount: _screens.length,
                itemBuilder: (context, index) => _CarouselPage(
                  controller: _pageController,
                  index: index,
                  initialPage: widget.initialIndex,
                  child: _screens[index],
                ),
              ),
            ),
            // ── Animated floating nav bar ───────────────────────────
            Positioned(
              left: horizontalMargin,
              right: horizontalMargin,
              bottom: verticalMargin,
              child: SlideTransition(
                position: _navBarSlide,
                child: Container(
                  height: navBarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: shadowBlur,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildFloatingNavItem(
                            iconPath: "assets/icons/dashboard.svg",
                            index: 0,
                            isCenter: false,
                            iconSize: iconSize,
                            centerIconSize: centerIconSize,
                          ),
                          _buildFloatingNavItem(
                            iconPath: "assets/icons/routes.svg",
                            index: 1,
                            isCenter: false,
                            iconSize: iconSize,
                            centerIconSize: centerIconSize,
                          ),
                          _buildFloatingNavItem(
                            iconPath: "assets/icons/students.svg",
                            index: 2,
                            isCenter: false,
                            iconSize: iconSize,
                            centerIconSize: centerIconSize,
                          ),
                          _buildFloatingNavItem(
                            iconPath: "assets/icons/attendance.svg",
                            index: 3,
                            isCenter: false,
                            iconSize: iconSize,
                            centerIconSize: centerIconSize,
                          ),
                          _buildFloatingNavItem(
                            iconPath: "assets/icons/user.svg",
                            index: 4,
                            isCenter: false,
                            iconSize: iconSize,
                            centerIconSize: centerIconSize,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// Wraps a tab so it stays alive across swipes and picks up a carousel-style
/// depth effect: pages scale down and fade slightly as they slide away.
class _CarouselPage extends StatefulWidget {
  final PageController controller;
  final int index;
  final int initialPage;
  final Widget child;

  const _CarouselPage({
    required this.controller,
    required this.index,
    required this.initialPage,
    required this.child,
  });

  @override
  State<_CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<_CarouselPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        // `page` is null until the controller is attached to a viewport.
        final page = widget.controller.hasClients &&
                widget.controller.position.haveDimensions
            ? widget.controller.page ?? widget.initialPage.toDouble()
            : widget.initialPage.toDouble();

        final distance = (page - widget.index).abs().clamp(0.0, 1.0);
        final scale = 1 - (distance * 0.08);
        final opacity = 1 - (distance * 0.35);

        return Opacity(
          opacity: opacity,
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: widget.child,
    );
  }
}
