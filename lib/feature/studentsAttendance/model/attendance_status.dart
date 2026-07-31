enum AttendanceStatus {
  present,
  absent,
  late,
  unmarked,
}

class StudentAttendanceItem {
  final String initials;
  final String name;
  final String admissionNo;
  final String rollNo;
  final String parentName;
  final String className;
  AttendanceStatus attendanceStatus;

  StudentAttendanceItem({
    required this.initials,
    required this.name,
    required this.admissionNo,
    required this.rollNo,
    required this.parentName,
    required this.className,
    required this.attendanceStatus,
  });
}