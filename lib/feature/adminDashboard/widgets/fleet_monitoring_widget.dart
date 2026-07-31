import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class FleetMonitoringWidget extends StatelessWidget {
  const FleetMonitoringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C5A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fleet Monitoring',
                    style: TextStyle(
                      fontSize: AppFontSize.h5(context),
                      fontWeight: AppFontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    '31 Vehicles are currently online',
                    style: TextStyle(
                      fontSize: AppFontSize.text3(context),
                      fontWeight: AppFontWeight.regular,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              _buildStatusItem(context, AppColors.running, '24', 'Running'),
              Container(
                width: 1,
                height: screenHeight * 0.04,
                color: Colors.white.withOpacity(0.3),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              ),
              _buildStatusItem(context, AppColors.idle, '4', 'Idle'),
              Container(
                width: 1,
                height: screenHeight * 0.04,
                color: Colors.white.withOpacity(0.3),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              ),
              _buildStatusItem(context, AppColors.stopped, '2', 'Stopped'),
              Container(
                width: 1,
                height: screenHeight * 0.04,
                color: Colors.white.withOpacity(0.3),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              ),
              _buildStatusItem(context, AppColors.inactive, '1', 'Inactive'),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.012,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Live Tracking',
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primary,
                  size: screenWidth * 0.04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, Color dotColor, String count, String label) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth * 0.025,
                height: screenWidth * 0.025,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: screenWidth * 0.015),
              Text(
                count,
                style: TextStyle(
                  fontSize: AppFontSize.h5(context),
                  fontWeight: AppFontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.caption(context),
              fontWeight: AppFontWeight.medium,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}