import 'package:body_part_selector/body_part_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coopmetrics/core/api_client_pain.dart';
import '../../enums.dart';
import '../../providers/page_notifier.dart';

class SilhouettePage extends StatefulWidget {
  const SilhouettePage({required this.title, super.key});

  final String title;

  @override
  State<SilhouettePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SilhouettePage> {
  final ApiClient _apiClient = ApiClient();
  BodyParts _bodyParts = const BodyParts();
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    // _getInitialDataForFeedbackForm();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
    });
    // not working – should be passed from the previous screen
    // final user_info = await _apiClient.getUserWithFeedbacks(_email);
    // userHasGroup = user_info["groups"].isNotEmpty;
    // prefs.setString('email', emailController.text);
  }

  Future<void> submitPain(notifier) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Danke für die Eingabe'),
      backgroundColor: Colors.green.shade300,
    ));
    // debugPrint(_bodyParts.toString());
    dynamic res = await _apiClient.submitPainToDatabase(
      _email,
      _bodyParts.head,
      _bodyParts.neck,
      _bodyParts.leftShoulder,
      _bodyParts.leftUpperArm,
      _bodyParts.leftElbow,
      _bodyParts.leftLowerArm,
      _bodyParts.leftHand,
      _bodyParts.rightShoulder,
      _bodyParts.rightUpperArm,
      _bodyParts.rightElbow,
      _bodyParts.rightLowerArm,
      _bodyParts.rightHand,
      _bodyParts.upperBody,
      _bodyParts.lowerBody,
      _bodyParts.leftUpperLeg,
      _bodyParts.leftKnee,
      _bodyParts.leftLowerLeg,
      _bodyParts.leftFoot,
      _bodyParts.rightUpperLeg,
      _bodyParts.rightKnee,
      _bodyParts.rightLowerLeg,
      _bodyParts.rightFoot,
      _bodyParts.abdomen,
      _bodyParts.vestibular,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (res['ErrorCode'] == null) {
      // notifier.changePage(
      //     page: PageName.feedbackReceived, unknown: false, pageIndex: 3);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res['Message']}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schmerz-Silhouette'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            notifier.changePage(
                page: PageName.home, unknown: false, pageIndex: 1);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              submitPain(notifier);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BodyPartSelectorTurnable(
          bodyParts: _bodyParts,
          onSelectionUpdated: (p) => setState(() => _bodyParts = p),
          labelData: const RotationStageLabelData(
            front: 'Vorne',
            left: 'Links',
            right: 'Rechts',
            back: 'Hinten',
          ),
        ),
      ),
    );
  }
}
