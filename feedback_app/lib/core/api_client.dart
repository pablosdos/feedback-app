import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:developer' as logging;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// for debugPrint
import 'package:flutter/material.dart';

class Feedback {
  int? id;
  String? User_id;
  int? group_id;
  String? group_name;
  String? group_of_user;
  String? created_at;
  int? motivation;
  int? muskulaere_erschoepfung;
  int? koerperliche_einschraenkung;
  int? schlaf;
  int? stress;

  Feedback(
      {this.id,
      this.User_id,
      this.group_id,
      this.group_name,
      this.group_of_user,
      this.created_at,
      this.motivation,
      this.muskulaere_erschoepfung,
      this.koerperliche_einschraenkung,
      this.schlaf,
      this.stress});

  Feedback.fromJson(Map<String, dynamic> json) {
    // debugPrint(json.toString());
    id = json['id'];
    User_id = json['User_id'];
    group_id = json['group_id'];
    group_name = json['group_name'];
    group_of_user = json['group_of_user'];
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
  int _group = 0;
  String apiKey = dotenv.env['API_URL']!;
  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${apiKey}/api-token-auth/',
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
        '${apiKey}/feedback-app-api/feedbacks/',
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

  Future<dynamic> getUserWithFeedbacks(user_email) async {
    try {
      Response response =
          await _dio.get('${apiKey}/feedback-app-api/users/$user_email');
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<void> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    // debugPrint(prefs.getString('groups').toString());
    // debugPrint(prefs.getString('email').toString());
    // debugPrint(prefs.toString());
  }

  Future<void> _getUserGroup() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    final user = await getUserWithFeedbacks(_email);
    _group = user["groups"][0] ?? 0;
  }

  Future<List<Feedback>> getFeedbacks() async {
    await _getUserEmail();
    var url = Uri.parse('${apiKey}/feedback-app-api/feedbacks/$_email');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Feedback.fromJson(e)).toList();
  }

  Future<List<Feedback>> getFeedbackOfToday() async {
    await _getUserEmail();
    var url = Uri.parse(
        '${apiKey}/feedback-app-api/feedbacks/$_email?only_today=True');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Feedback.fromJson(e)).toList();
  }

  Future<List<Feedback>> getFeedbacksOfGroup() async {
    await _getUserEmail();
    await _getUserGroup();
    var url = Uri.parse('${apiKey}/feedback-app-api/feedbacks/$_group?arithmetic_mean=True');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    // debugPrint(body.toString());
    return body.map((e) => Feedback.fromJson(e)).toList();
  }
}
