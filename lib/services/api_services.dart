import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String _bearerToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';




  //login request post api call
  Future<Response> Loginpost(String url, Map<String, dynamic> body) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }


  //post api call
  Future<Response> post(
      String url,
      Map<String, dynamic> body, {
        Map<String, String>? customHeaders,
      }) async {
    try {
      // Merge default headers with custom headers if provided
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_bearerToken",
        ...?customHeaders, // Spread operator to include custom headers
      };

      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }

  void setBearerToken(String token) {
    _bearerToken = token;
  }
}