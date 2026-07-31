
class ApiException implements Exception {
  final String message;
  final int returnValue;

  ApiException({required this.message, required this.returnValue});

  @override
  String toString() => message;
}