import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:feedback_app/screens/home.dart';
import 'package:feedback_app/core/api_client.dart';
import 'package:feedback_app/screens/home.dart';
import 'package:feedback_app/utils/validator.dart';

class PersonalStatsScreen extends StatefulWidget {
  @override
  State<PersonalStatsScreen> createState() => _PersonalStatsScreenState();
}

class _PersonalStatsScreenState extends State<PersonalStatsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
    );
  }
}
