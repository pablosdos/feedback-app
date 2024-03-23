import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as logging;
import 'package:shared_preferences/shared_preferences.dart';

class Feedback {
  int? id;
  String? User_id;
  String? created_at;
  int? motivation;
  int? muskulaere_erschoepfung;
  int? koerperliche_einschraenkung;
  int? schlaf;
  int? stress;

  Feedback(
      {this.id,
      this.User_id,
      this.created_at,
      this.motivation,
      this.muskulaere_erschoepfung,
      this.koerperliche_einschraenkung,
      this.schlaf,
      this.stress});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    User_id = json['User_id'];
    created_at = json['created_at'];
    motivation = json['motivation'];
    muskulaere_erschoepfung = json['muskulaere_erschoepfung'];
    koerperliche_einschraenkung = json['koerperliche_einschraenkung'];
    schlaf = json['schlaf'];
    stress = json['stress'];
  }
}

class ApiClient {
  final Dio _dio = Dio();
  String _email = '';

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

  Future<dynamic> getUserWithFeedbacks() async {
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

  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    // debugPrint('enter home screen with: $_email');
  }

  Future<List<Feedback>> getFeedbacks() async {
    await _getUserEmail();
    print('http://localhost:8000/feedback-app-api/feedbacks/$_email');
    var url = Uri.parse(
      'http://localhost:8000/feedback-app-api/feedbacks/$_email',
      // 'http://feedback-app.paul-kluge.de:8000/feedback-app-api/feedbacks/$_email',
    );
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    // logging.log(response.body);
    final List body = json.decode(response.body);
    return body.map((e) => Feedback.fromJson(e)).toList();
  }

  // Future<List<Feedback>> feedbacksFuture = getFeedbacks();
}
