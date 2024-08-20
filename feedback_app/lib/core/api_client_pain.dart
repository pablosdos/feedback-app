import 'dart:ffi';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:developer' as logging;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// for debugPrint

class ApiClient {
  final Dio _dio = Dio();
  String _email = '';
  int _group = 0;
  String apiUrl = dotenv.env['API_URL']!;
  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '$apiUrl/api-token-auth/',
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

  Future<dynamic> submitPainToDatabase(
    String email,
    bool head,
    bool neck,
    bool leftShoulder,
    bool leftUpperArm,
    bool leftElbow,
    bool leftLowerArm,
    bool leftHand,
    bool rightShoulder,
    bool rightUpperArm,
    bool rightElbow,
    bool rightLowerArm,
    bool rightHand,
    bool upperBody,
    bool lowerBody,
    bool leftUpperLeg,
    bool leftKnee,
    bool leftLowerLeg,
    bool leftFoot,
    bool rightUpperLeg,
    bool rightKnee,
    bool rightLowerLeg,
    bool rightFoot,
    bool abdomen,
    bool vestibular,
  ) async {
    try {
      Response response = await _dio.post(
        '$apiUrl/feedback-app-api/pains/',
        data: {
          "User": "hoffner@fc-unterneukirchen.de",
          "head": head,
          "neck": neck,
          "leftShoulder": leftShoulder,
          "leftUpperArm": leftUpperArm,
          "leftElbow": leftElbow,
          "leftLowerArm": leftLowerArm,
          "leftHand": leftHand,
          "rightShoulder": rightShoulder,
          "rightUpperArm": rightUpperArm,
          "rightElbow": rightElbow,
          "rightLowerArm": rightLowerArm,
          "rightHand": rightHand,
          "upperBody": upperBody,
          "lowerBody": lowerBody,
          "leftUpperLeg": leftUpperLeg,
          "leftKnee": leftKnee,
          "leftLowerLeg": leftLowerLeg,
          "leftFoot": leftFoot,
          "rightUpperLeg": rightUpperLeg,
          "rightKnee": rightKnee,
          "rightLowerLeg": rightLowerLeg,
          "rightFoot": rightFoot,
          "abdomen": abdomen,
          "vestibular": vestibular
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
