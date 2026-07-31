import 'package:flutter/material.dart';
import 'package:sts/feature/admindashboard/widgets/section_header_widget.dart';

import '../../../utils/app_colors.dart';
import 'child_card_widget.dart';

class MyChildrenSectionWidget extends StatelessWidget {
  const MyChildrenSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: 'My Children',
          onViewAll: () {},
        ),
        SizedBox(height: screenWidth * 0.03),
        const ChildCardWidget(
          name: 'Aiden Clark',
          className: 'Class 4A',
          rollNumber: '001',
          attendance: '92',
          grade: 'A',
          busId: 'BUS-001',
          eta: '8 min',
        ),
        SizedBox(height: screenWidth * 0.025),
        const ChildCardWidget(
          name: 'Sophie Clark',
          className: 'Class 2B',
          rollNumber: '015',
          attendance: '96',
          grade: 'A+',
          busId: 'BUS-001',
          eta: '8 min',
        ),
        // You can add more children here
        // SizedBox(height: screenWidth * 0.025),
        // const ChildCardWidget(
        //   name: 'Emma Clark',
        //   className: 'Class 5C',
        //   rollNumber: '023',
        //   attendance: '88',
        //   grade: 'B+',
        //   busId: 'BUS-002',
        //   eta: '15 min',
        // ),
      ],
    );
  }
}