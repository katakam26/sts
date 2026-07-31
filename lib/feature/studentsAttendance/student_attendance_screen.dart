import 'package:flutter/material.dart';
import 'package:sts/feature/studentsAttendance/widget/attendance_header_widget.dart';
import 'package:sts/feature/studentsAttendance/widget/attendance_search_bar_widget.dart';
import 'package:sts/feature/studentsAttendance/widget/attendance_summary_chips_widget.dart';
import 'package:sts/feature/studentsAttendance/widget/student_attendance_card_widget.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_font_size.dart';
import '../../utils/app_font_weight.dart';
import 'model/attendance_status.dart';

// ==================== STUDENT ATTENDANCE SCREEN ====================
class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  String searchQuery = '';

  final List<StudentAttendanceItem> students = [
    StudentAttendanceItem(
      initials: 'AC',
      name: 'Aiden Clark',
      admissionNo: '0001',
      rollNo: '001',
      parentName: 'Sarah Clark',
      className: '4A',
      attendanceStatus: AttendanceStatus.late,
    ),
    StudentAttendanceItem(
      initials: 'BM',
      name: 'Bella Martinez',
      admissionNo: '0002',
      rollNo: '002',
      parentName: 'Luis Martinez',
      className: '4A',
      attendanceStatus: AttendanceStatus.absent,
    ),
    StudentAttendanceItem(
      initials: 'CJ',
      name: 'Carlos Johnson',
      admissionNo: '0003',
      rollNo: '003',
      parentName: 'Mike Johnson',
      className: '4A',
      attendanceStatus: AttendanceStatus.absent,
    ),
    StudentAttendanceItem(
      initials: 'DL',
      name: 'Diana Lee',
      admissionNo: '0004',
      rollNo: '004',
      parentName: 'Jenny Lee',
      className: '4A',
      attendanceStatus: AttendanceStatus.unmarked,
    ),
    StudentAttendanceItem(
      initials: 'EB',
      name: 'Ethan Brown',
      admissionNo: '0005',
      rollNo: '005',
      parentName: 'Tom Brown',
      className: '4A',
      attendanceStatus: AttendanceStatus.unmarked,
    ),
    StudentAttendanceItem(
      initials: 'FD',
      name: 'Fiona Davis',
      admissionNo: '0006',
      rollNo: '006',
      parentName: 'Carol Davis',
      className: '4A',
      attendanceStatus: AttendanceStatus.present,
    ),
    StudentAttendanceItem(
      initials: 'GW',
      name: 'George Wilson',
      admissionNo: '0007',
      rollNo: '007',
      parentName: 'Paul Wilson',
      className: '4A',
      attendanceStatus: AttendanceStatus.unmarked,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // Header with Saved Badge
              const AttendanceHeaderWidget(),

              SizedBox(height: screenHeight * 0.02),

              // Date
              Text(
                'Monday, July 20',
                style: TextStyle(
                  fontSize: AppFontSize.text3(context),
                  fontWeight: AppFontWeight.regular,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Attendance Summary Chips
              const AttendanceSummaryChipsWidget(
                presentCount: 1,
                absentCount: 2,
                lateCount: 1,
                unmarkedCount: 4,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Search Bar
              const AttendanceSearchBarWidget(),

              SizedBox(height: screenHeight * 0.02),

              // Student Attendance List
              ...students.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: screenWidth * 0.03),
                  child: StudentAttendanceCardWidget(
                    student: entry.value,
                    onStatusChanged: (status) {
                      setState(() {
                        students[entry.key].attendanceStatus = status;
                      });
                    },
                  ),
                );
              }),

              SizedBox(height: screenHeight * 0.12),
            ],
          ),
        ),
      ),
    );
  }

}
