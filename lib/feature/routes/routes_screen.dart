import 'package:flutter/material.dart';
import 'package:sts/feature/routes/widgets/add_stop_bottom_sheet_widget.dart';
import 'package:sts/feature/routes/widgets/route_card_widget.dart';
import 'package:sts/feature/routes/widgets/routes_header_widget.dart';

import '../../utils/app_colors.dart';
import 'models/stop_item.dart';

// ==================== ROUTES SCREEN ====================
class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  // Track which route is expanded
  int? expandedRouteIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // Header with Add Route button
              const RoutesHeaderWidget(),

                SizedBox(height: screenHeight * 0.025),

                // Route Cards List
                RouteCardWidget(
                  routeName: 'Route A - North',
                  busId: 'BUS-001',
                  stopsCount: 4,
                  distance: '12.4 km',
                  isExpanded: expandedRouteIndex == 0,
                  onTap: () {
                    setState(() {
                      expandedRouteIndex = expandedRouteIndex == 0 ? null : 0;
                    });
                  },
                  stops: [
                    StopItem(
                      stopName: 'Pine Avenue Stop',
                      time: '7:10 AM',
                      type: 'Pick-up',
                      studentCount: 7,
                      stopType: 'P',
                    ),
                    StopItem(
                      stopName: 'Birch Drive',
                      time: '7:22 AM',
                      type: 'Pick-up',
                      studentCount: 5,
                      stopType: 'P',
                    ),
                    StopItem(
                      stopName: 'Walnut Way',
                      time: '7:32 AM',
                      type: 'Pick-up',
                      studentCount: 6,
                      stopType: 'P',
                    ),
                  ],
                  onAddStop: () => _showAddStopBottomSheet(context),
                ),

                SizedBox(height: screenWidth * 0.03),

                RouteCardWidget(
                  routeName: 'Route B - South',
                  busId: 'BUS-002',
                  stopsCount: 3,
                  distance: '9.8 km',
                  isExpanded: expandedRouteIndex == 1,
                  onTap: () {
                    setState(() {
                      expandedRouteIndex = expandedRouteIndex == 1 ? null : 1;
                    });
                  },
                  stops: [
                    StopItem(
                      stopName: 'Oak Street Stop',
                      time: '7:15 AM',
                      type: 'Pick-up',
                      studentCount: 8,
                      stopType: 'P',
                    ),
                    StopItem(
                      stopName: 'Maple Lane',
                      time: '7:25 AM',
                      type: 'Pick-up',
                      studentCount: 4,
                      stopType: 'P',
                    ),
                  ],
                  onAddStop: () => _showAddStopBottomSheet(context),
                ),

                SizedBox(height: screenWidth * 0.03),

                RouteCardWidget(
                  routeName: 'Route C - East',
                  busId: 'BUS-003',
                  stopsCount: 3,
                  distance: '11.2 km',
                  isExpanded: expandedRouteIndex == 2,
                  onTap: () {
                    setState(() {
                      expandedRouteIndex = expandedRouteIndex == 2 ? null : 2;
                    });
                  },
                  stops: [
                    StopItem(
                      stopName: 'Cedar Road',
                      time: '7:05 AM',
                      type: 'Pick-up',
                      studentCount: 6,
                      stopType: 'P',
                    ),
                    StopItem(
                      stopName: 'Elm Boulevard',
                      time: '7:18 AM',
                      type: 'Pick-up',
                      studentCount: 9,
                      stopType: 'P',
                    ),
                  ],
                  onAddStop: () => _showAddStopBottomSheet(context),
                ),

                SizedBox(height: screenHeight * 0.12), // Added space for bottom nav
              ],
            ),
          ),
        ),
    );
  }

  // Show Add Stop Bottom Sheet
  void _showAddStopBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddStopBottomSheetWidget(),
    );
  }
}
