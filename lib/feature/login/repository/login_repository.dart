import '../../../services/api_services.dart';
import '../../../services/api_urls.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';


class LoginRepository {
  final ApiService _apiService;

  LoginRepository(this._apiService);

  Future<LoginResponse> login(
      LoginRequest request,
      ) async {
    final url = AppUrls.loginUrl.trim();
    final body = request.toJson();

    print("API CALL: POST $url");
    print("BODY: $body");

    try {
      final response = await _apiService.Loginpost(url, body);
      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE DATA: ${response.data}");

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      print("API ERROR: $e");
      rethrow;
    }
  }
}
