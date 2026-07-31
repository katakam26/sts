import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_font_size.dart';
import '../utils/app_font_weight.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Teal background color from the image
    const sidebarColor = Color(0xFF62D2D7);

    return Drawer(
      width: screenWidth * 0.75,
      backgroundColor: sidebarColor,
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
                    backgroundColor: Colors.blue.shade400, // Placeholder blue for profile
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
                          color: Colors.white.withOpacity(0.9),
                          fontSize: AppFontSize.text3(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                children: [
                  _buildSidebarItem(
                    context,
                    icon: Icons.location_on_outlined,
                    title: 'Live Tracking',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.map_outlined,
                    title: 'History Tracking',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.add_road_outlined,
                    title: 'Add Route',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.route_outlined,
                    title: 'Routes',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.stop_circle_outlined,
                    title: 'Add Stop',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.assignment_ind_outlined,
                    title: 'Assign Vehicle',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.assignment_outlined,
                    title: 'View Assign Vehicles',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.camera_alt_outlined,
                    title: 'Camera VehicleList',
                    onTap: () {},
                  ),
                  _buildSidebarItem(
                    context,
                    icon: Icons.contact_phone_outlined,
                    title: 'Contact Us',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: screenWidth * 0.07,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: AppFontSize.h6(context),
          fontWeight: AppFontWeight.medium,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 4,
      ),
    );
  }
}
