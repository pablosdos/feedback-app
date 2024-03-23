import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://localhost:8000/api-token-auth/',
        // 'http://feedback-app.paul-kluge.de:8000/api-token-auth/',
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

  Future<dynamic> submitFeedbackToDatabase(
    String email,
    String motivation,
    String muskulaereErschoepfung,
    String koerperlicheEinschraenkung,
    String schlaf,
    String stress,
  ) async {
    try {
      Response response = await _dio.post(
        'http://localhost:8000/feedback-app-api/feedbacks/',
        // 'http://feedback-app.paul-kluge.de:8000/feedback-app-api/feedbacks/',
        data: {
          "User": email,
          "motivation": motivation,
          "muskulaere_erschoepfung": muskulaereErschoepfung,
          "koerperliche_einschraenkung": koerperlicheEinschraenkung,
          "schlaf": schlaf,
          "stress": stress
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserWithFeedbacks(
  ) async {
    try {
      Response response = await _dio.get(
        'http://localhost:8000/feedback-app-api/users/dev@dev.de',
        // 'http://feedback-app.paul-kluge.de:8000/feedback-app-api/users/dev@dev.de',
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
