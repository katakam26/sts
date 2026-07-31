import 'package:dio/dio.dart';



class ApiService {
  final Dio _dio = Dio();


  Future<Response> login(String url, Map<String, dynamic> body) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      return response;
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }

  Future<Response> post(
      String url,
      Map<String, dynamic> body, {
        String? token,
      }) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (token != null) "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      throw Exception("API Error: ${e.response?.data ?? e.message}");
    }
  }

  Future<Response> get(
      String url, {
        String? token,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (token != null) "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      throw Exception("API Error: ${e.response?.data ?? e.message}");
    }
  }


}
