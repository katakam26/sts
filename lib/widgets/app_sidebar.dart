import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_font_size.dart';
import '../utils/app_font_weight.dart';

/// One service entry in the drawer. [tabIndex] points at a bottom-nav
/// destination when the service already has a screen, and is null while the
/// service is still to be built.
class _SidebarItem {
  final IconData icon;
  final String title;
  final int? tabIndex;

  const _SidebarItem(this.icon, this.title, {this.tabIndex});
}

class AppSidebar extends StatefulWidget {
  /// Switches the bottom-nav carousel to a tab. Supplied by MainBottomNav.
  final ValueChanged<int>? onSelectDestination;

  const AppSidebar({super.key, this.onSelectDestination});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  // Remembers the last service tapped so the drawer shows where you were.
  int _selectedIndex = -1;

  static const List<_SidebarItem> _items = [
    _SidebarItem(Icons.location_on_outlined, 'Live Tracking'),
    _SidebarItem(Icons.map_outlined, 'History Tracking'),
    _SidebarItem(Icons.add_road_outlined, 'Add Route', tabIndex: 1),
    _SidebarItem(Icons.route_outlined, 'Routes', tabIndex: 1),
    _SidebarItem(Icons.stop_circle_outlined, 'Add Stop', tabIndex: 1),
    _SidebarItem(Icons.assignment_ind_outlined, 'Assign Vehicle'),
    _SidebarItem(Icons.assignment_outlined, 'View Assign Vehicles'),
    _SidebarItem(Icons.camera_alt_outlined, 'Camera VehicleList'),
    _SidebarItem(Icons.contact_phone_outlined, 'Contact Us'),
  ];

  void _onItemSelected(int index) {
    final item = _items[index];
    setState(() => _selectedIndex = index);

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Let the highlight register before the drawer slides away.
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;
      navigator.pop();

      if (item.tabIndex != null) {
        widget.onSelectDestination?.call(item.tabIndex!);
      }

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(item.icon, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.tabIndex != null
                        ? 'Opening ${item.title}'
                        : '${item.title} is coming soon',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      width: screenWidth * 0.75,
      backgroundColor: AppColors.primary,
      child: DecoratedBox(
        // Brand gradient, replacing the old hardcoded teal.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Drawer Header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.03,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.08,
                      backgroundColor: Colors.white,
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: AppFontSize.h4(context),
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'sudharani',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFontSize.h6(context),
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        Text(
                          'Active Status',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: AppFontSize.text3(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.white.withValues(alpha: 0.25),
                height: 1,
                indent: screenWidth * 0.06,
                endIndent: screenWidth * 0.06,
              ),

              // Service cards
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) => _buildSidebarCard(
                    context,
                    item: _items[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => _onItemSelected(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A card per service. The selected one turns solid white with brand
  /// coloured text, so it stays obvious which service was opened.
  Widget _buildSidebarCard(
    BuildContext context, {
    required _SidebarItem item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Color foreground = isSelected ? AppColors.primary : Colors.white;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.012),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          border: Border.all(
            color: Colors.white.withValues(alpha: isSelected ? 1.0 : 0.22),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: screenWidth * 0.03,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(screenWidth * 0.035),
            splashColor: Colors.white.withValues(alpha: 0.25),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.035,
                vertical: screenHeight * 0.016,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Icon(
                      item.icon,
                      color: foreground,
                      size: screenWidth * 0.055,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.035),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: foreground,
                        fontSize: AppFontSize.text2(context),
                        fontWeight: isSelected
                            ? AppFontWeight.bold
                            : AppFontWeight.medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: foreground.withValues(alpha: 0.7),
                    size: screenWidth * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
