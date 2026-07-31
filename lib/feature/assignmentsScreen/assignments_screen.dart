import 'package:flutter/material.dart';
import 'package:sts/feature/assignmentsScreen/widgets/assignment_card_widget.dart';
import 'package:sts/feature/assignmentsScreen/widgets/assignments_header_widget.dart';
import 'package:sts/feature/assignmentsScreen/widgets/assignments_tab_bar_widget.dart';
import 'package:sts/feature/assignmentsScreen/widgets/diary_card_widget.dart';
import 'package:sts/feature/assignmentsScreen/widgets/note_card_widget.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_font_size.dart';
import '../../utils/app_font_weight.dart';

// ==================== ASSIGNMENTS SCREEN ====================
class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header with Add Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: const AssignmentsHeaderWidget(),
            ),

            SizedBox(height: screenHeight * 0.005),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Class 4A · 3 items',
                style: TextStyle(
                  fontSize: AppFontSize.caption(context),
                  fontWeight: AppFontWeight.regular,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: AssignmentsTabBarWidget(tabController: _tabController),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Assignments Tab
                  _buildAssignmentsList(context),
                  // Diary Tab
                  _buildDiaryList(context),
                  // Notes Tab
                  _buildNotesList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildAssignmentsList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          AssignmentCardWidget(
            subject: 'Mathematics',
            subjectColor: AppColors.primary,
            subjectBgColor: AppColors.primary.withValues(alpha: 0.1),
            dueDate: 'Due 07-20',
            title: 'Chapter 5 Math Problems',
            description: 'Complete exercises 5.1 to 5.5 from textbook',
            addedDate: 'Added 2026-07-18',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
          AssignmentCardWidget(
            subject: 'English',
            subjectColor: AppColors.primary,
            subjectBgColor: AppColors.primary.withValues(alpha: 0.1),
            dueDate: 'Due 07-22',
            title: 'English Essay: My Favorite Season',
            description: 'Write 200-300 word essay about your favorite season',
            addedDate: 'Added 2026-07-17',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
          AssignmentCardWidget(
            subject: 'Science',
            subjectColor: AppColors.primary,
            subjectBgColor: AppColors.primary.withValues(alpha: 0.1),
            dueDate: 'Due 07-25',
            title: 'Science Project: Water Cycle',
            description: 'Create a diagram of the water cycle with labels',
            addedDate: 'Added 2026-07-16',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
        ],
      ),
    );
  }

  Widget _buildDiaryList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          DiaryCardWidget(
            date: 'Monday, July 20',
            title: 'Field Trip to Science Museum',
            content:
            'Students visited the city science museum today. Everyone enjoyed the interactive exhibits.',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
          DiaryCardWidget(
            date: 'Friday, July 17',
            title: 'Sports Day Practice',
            content:
            'Class practiced for upcoming sports day. Relay race teams were formed.',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
        ],
      ),
    );
  }

  Widget _buildNotesList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          NoteCardWidget(
            title: 'Parent Meeting Notes',
            content:
            'Discussed student progress with parents. Most students are performing well in mathematics.',
            date: '2026-07-18',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
          NoteCardWidget(
            title: 'Classroom Rules Update',
            content:
            'New rules for group discussions have been implemented. Students are responding positively.',
            date: '2026-07-15',
            classBadge: '4A',
          ),
          SizedBox(height: screenWidth * 0.03),
        ],
      ),
    );
  }

}
