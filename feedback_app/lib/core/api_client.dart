import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://localhost:8000/api-token-auth/',
        data: {
          'username': email,
          'password': password,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> submitFeedback() async {
    try {
      Response response = await _dio.post(
        'http://localhost:8000/api-token-auth/',
        data: {
      
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/account',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
