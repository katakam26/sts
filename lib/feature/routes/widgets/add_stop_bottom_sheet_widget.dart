import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';

class AddStopBottomSheetWidget extends StatefulWidget {
  const AddStopBottomSheetWidget({super.key});

  @override
  State<AddStopBottomSheetWidget> createState() => _AddStopBottomSheetWidgetState();
}

class _AddStopBottomSheetWidgetState extends State<AddStopBottomSheetWidget> {
  String selectedStopType = 'Pick-up';

  // Time variables
  TimeOfDay pickupTime = const TimeOfDay(hour: 7, minute: 30);
  TimeOfDay dropoffTime = const TimeOfDay(hour: 18, minute: 0);

  // Controllers for text fields
  final TextEditingController stopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController dropoffTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pickupTimeController.text = _formatTime(pickupTime);
    dropoffTimeController.text = _formatTime(dropoffTime);
  }

  @override
  void dispose() {
    stopNameController.dispose();
    addressController.dispose();
    pickupTimeController.dispose();
    dropoffTimeController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _showTimePicker(
      BuildContext context, {
        required TimeOfDay initialTime,
        required Function(TimeOfDay) onTimeSelected,
        required TextEditingController controller,
        String title = 'Select Time',
      }) async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Selected time state for the picker
    TimeOfDay selectedTime = initialTime;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateModal) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: screenWidth * 0.15,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMuted.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppFontSize.h4(context),
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Custom Time Picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hour picker
                      _buildTimePickerColumn(
                        context,
                        items: List.generate(12, (index) => index + 1),
                        selectedValue: selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod,
                        onChanged: (value) {
                          setStateModal(() {
                            int newHour = value;
                            if (selectedTime.period == DayPeriod.pm && newHour != 12) {
                              newHour += 12;
                            } else if (selectedTime.period == DayPeriod.am && newHour == 12) {
                              newHour = 0;
                            }
                            selectedTime = TimeOfDay(hour: newHour, minute: selectedTime.minute);
                          });
                        },
                        label: 'Hour',
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      // Minute picker
                      _buildTimePickerColumn(
                        context,
                        items: List.generate(60, (index) => index),
                        selectedValue: selectedTime.minute,
                        onChanged: (value) {
                          setStateModal(() {
                            selectedTime = TimeOfDay(hour: selectedTime.hour, minute: value);
                          });
                        },
                        label: 'Minute',
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      // AM/PM picker
                      _buildTimePickerColumn(
                        context,
                        items: ['AM', 'PM'],
                        selectedValue: selectedTime.period == DayPeriod.am ? 'AM' : 'PM',
                        onChanged: (value) {
                          setStateModal(() {
                            int newHour = selectedTime.hour;
                            if (value == 'AM' && selectedTime.hour >= 12) {
                              newHour -= 12;
                            } else if (value == 'PM' && selectedTime.hour < 12) {
                              newHour += 12;
                            }
                            selectedTime = TimeOfDay(hour: newHour, minute: selectedTime.minute);
                          });
                        },
                        label: 'Period',
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  // Confirm Button
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.018,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              border: Border.all(
                                color: AppColors.cardBorder.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: AppFontSize.text(context),
                                  fontWeight: AppFontWeight.medium,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              onTimeSelected(selectedTime);
                              controller.text = _formatTime(selectedTime);
                            });
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.018,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                            child: Center(
                              child: Text(
                                'Confirm Time',
                                style: TextStyle(
                                  fontSize: AppFontSize.text(context),
                                  fontWeight: AppFontWeight.semiBold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimePickerColumn<T>(
      BuildContext context, {
        required List<T> items,
        required T selectedValue,
        required Function(T) onChanged,
        required String label,
      }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppFontSize.overline(context),
            fontWeight: AppFontWeight.bold,
            color: AppColors.textMuted,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          height: screenHeight * 0.2,
          width: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            border: Border.all(
              color: AppColors.cardBorder.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(
              initialItem: items.indexOf(selectedValue),
            ),
            itemExtent: screenHeight * 0.05,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              onChanged(items[index]);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                final isSelected = items[index] == selectedValue;
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    items[index].toString(),
                    style: TextStyle(
                      fontSize: isSelected ? AppFontSize.h4(context) : AppFontSize.text2(context),
                      fontWeight: isSelected ? AppFontWeight.bold : AppFontWeight.medium,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Stop',
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
                _buildLabel(context, 'STOP NAME'),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(context, 'e.g. Main Gate', stopNameController),

                SizedBox(height: screenHeight * 0.02),

                // Address Field
                _buildLabel(context, 'ADDRESS'),
                SizedBox(height: screenHeight * 0.008),
                _buildTextField(context, 'e.g. 10 Station Road', addressController),

                SizedBox(height: screenHeight * 0.02),

                // Stop Type Label
                _buildLabel(context, 'STOP TYPE'),
                SizedBox(height: screenHeight * 0.01),

                // Stop Type Toggle - Three options
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    border: Border.all(
                      color: AppColors.cardBorder.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStopTypeButton(
                          context,
                          label: 'Pick-up',
                          isSelected: selectedStopType == 'Pick-up',
                          onTap: () {
                            setState(() {
                              selectedStopType = 'Pick-up';
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildStopTypeButton(
                          context,
                          label: 'Both',
                          isSelected: selectedStopType == 'Both',
                          onTap: () {
                            setState(() {
                              selectedStopType = 'Both';
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildStopTypeButton(
                          context,
                          label: 'Drop-off',
                          isSelected: selectedStopType == 'Drop-off',
                          onTap: () {
                            setState(() {
                              selectedStopType = 'Drop-off';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Time pickers based on selection
                if (selectedStopType == 'Pick-up' || selectedStopType == 'Both')
                  _buildTimePickerField(
                    context,
                    label: 'PICKUP TIME',
                    controller: pickupTimeController,
                    time: pickupTime,
                    onTap: () => _showTimePicker(
                      context,
                      initialTime: pickupTime,
                      onTimeSelected: (time) => pickupTime = time,
                      controller: pickupTimeController,
                      title: 'Select Pickup Time',
                    ),
                  ),

                if (selectedStopType == 'Both')
                  SizedBox(height: screenHeight * 0.02),

                if (selectedStopType == 'Drop-off' || selectedStopType == 'Both')
                  _buildTimePickerField(
                    context,
                    label: 'DROPOFF TIME',
                    controller: dropoffTimeController,
                    time: dropoffTime,
                    onTap: () => _showTimePicker(
                      context,
                      initialTime: dropoffTime,
                      onTimeSelected: (time) => dropoffTime = time,
                      controller: dropoffTimeController,
                      title: 'Select Dropoff Time',
                    ),
                  ),

                SizedBox(height: screenHeight * 0.025),

                // Add Stop Button
                InkWell(
                  onTap: () {
                    // Handle add stop logic
                    Navigator.pop(context, {
                      'stopName': stopNameController.text,
                      'address': addressController.text,
                      'stopType': selectedStopType,
                      'pickupTime': _formatTime(pickupTime),
                      'dropoffTime': _formatTime(dropoffTime),
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

  Widget _buildTimePickerField(
      BuildContext context, {
        required String label,
        required TextEditingController controller,
        required TimeOfDay time,
        required VoidCallback onTap,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context, label),
        SizedBox(height: screenHeight * 0.008),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text,
                  style: TextStyle(
                    fontSize: AppFontSize.text3(context),
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(
                  Icons.access_time,
                  color: AppColors.primary,
                  size: screenWidth * 0.06,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStopTypeButton(
      BuildContext context, {
        required String label,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(screenWidth * 0.025),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.014,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppFontSize.text3(context),
              fontWeight: isSelected ? AppFontWeight.semiBold : AppFontWeight.medium,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}