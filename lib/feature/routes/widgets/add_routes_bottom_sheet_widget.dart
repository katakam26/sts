import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class AddRoutesBottomSheetWidget extends StatefulWidget {
  const AddRoutesBottomSheetWidget({super.key});

  @override
  State<AddRoutesBottomSheetWidget> createState() => _AddRoutesBottomSheetWidgetState();
}

class _AddRoutesBottomSheetWidgetState extends State<AddRoutesBottomSheetWidget> {
  String selectedStopType = 'Pick-up';



  // Controllers for text fields
  final TextEditingController stopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController dropoffTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    stopNameController.dispose();
    addressController.dispose();
    pickupTimeController.dispose();
    dropoffTimeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // Header with Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Route',
                      style: TextStyle(
                        fontSize: AppFontSize.h4(context),
                        fontWeight: AppFontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    )
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                // Stop Name Field
                _buildLabel(context, 'Route NAME'),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(context, 'e.g. Main Gate', stopNameController),

                SizedBox(height: screenHeight * 0.02),

                // Address Field
                _buildLabel(context, 'ADDRESS'),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(context, 'e.g. 10 Station Road', addressController),


                SizedBox(height: screenHeight * 0.01),
                // Add Stop Button
                InkWell(
                  onTap: () {
                    // Handle add stop logic
                    Navigator.pop(context, {
                      'stopName': stopNameController.text,
                      'address': addressController.text,
                      'stopType': selectedStopType
                    });
                  },
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.018,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: Center(
                      child: Text(
                        'Add Stop',
                        style: TextStyle(
                          fontSize: AppFontSize.text(context),
                          fontWeight: AppFontWeight.semiBold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppFontSize.overline(context),
        fontWeight: AppFontWeight.bold,
        color: AppColors.textMuted,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, TextEditingController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.012,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: TextField(
        cursorColor: AppColors.primary,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: AppFontSize.text3(context),
            fontWeight: AppFontWeight.regular,
            color: AppColors.textMuted,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}