import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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

  // Lucide glyphs, one per destination, in the same order as _screens.
  // Names map to the lucide slugs: layout-dashboard, route, users,
  // clipboard-check, circle-user.
  static const List<IconData> _navIcons = [
    LucideIcons.layoutDashboard,
    LucideIcons.route,
    LucideIcons.users,
    LucideIcons.clipboardCheck,
    LucideIcons.circleUser,
  ];

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

  // Live page position, so the pill tracks a swipe mid-drag instead of only
  // snapping once the page settles.
  double get _pageValue {
    if (_pageController.hasClients && _pageController.position.haveDimensions) {
      return _pageController.page ?? _currentIndex.toDouble();
    }
    return _currentIndex.toDouble();
  }

  /// [selection] is 1.0 when this tab is fully in view and 0.0 once it is a
  /// whole page away, so the icon tints and grows continuously while dragging.
  Widget _buildFloatingNavItem({
    required IconData icon,
    required int index,
    required double selection,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Icon(
          icon,
          size: iconSize * (1 + 0.18 * selection),
          color: Color.lerp(
            Colors.grey.shade600,
            AppColors.primary,
            selection,
          ),
        ),
      ),
    );
  }

  /// Nav bar contents: a pill that slides under the active icon, with the five
  /// destinations laid out over it.
  Widget _buildNavBarContent(double iconSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = constraints.maxWidth / _navIcons.length;
        final double pillWidth = itemWidth * 0.74;
        final double pillHeight = constraints.maxHeight * 0.68;

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, _) {
            final double page =
                _pageValue.clamp(0.0, (_navIcons.length - 1).toDouble());

            return Stack(
              children: [
                // Sliding pill, driven by the live page value.
                Positioned(
                  left: page * itemWidth + (itemWidth - pillWidth) / 2,
                  top: (constraints.maxHeight - pillHeight) / 2,
                  width: pillWidth,
                  height: pillHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.20),
                          AppColors.primaryLight.withValues(alpha: 0.12),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(pillHeight / 2),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var i = 0; i < _navIcons.length; i++)
                      SizedBox(
                        width: itemWidth,
                        height: constraints.maxHeight,
                        child: _buildFloatingNavItem(
                          icon: _navIcons[i],
                          index: i,
                          selection: (1 - (page - i).abs()).clamp(0.0, 1.0),
                          iconSize: iconSize,
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        );
      },
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
        drawer: AppSidebar(onSelectDestination: _onItemTapped),
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
                      child: _buildNavBarContent(iconSize),
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
