import 'package:pinntag/api/api_services.dart';
import 'package:pinntag/api/endpoints.dart';
import 'package:pinntag/auth/model/login_response.dart';

class LoginRepo {
  final ApiService _apiService = ApiService.to;

  Future<LoginResponseModel> loginUserApi(String email, String password) async {
    try {
      final data = {"email": email, "password": password, "fcmToken": ""};

      final response = await _apiService.request(
        HttpMethod.POST,
        path: Endpoints.loginUser,
        data: data,
      );

      return LoginResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
