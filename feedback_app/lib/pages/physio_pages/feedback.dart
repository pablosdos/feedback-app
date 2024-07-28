import 'package:body_part_selector/body_part_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../providers/page_notifier.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({required this.title, super.key});

  final String title;

  @override
  State<FeedbackPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FeedbackPage> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feedback'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              notifier.changePage(
                  page: PageName.home, unknown: false, pageIndex: 1);
            },
          ),
        ),
        body: const Center(
            child: Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 50,
            child: Text(
              "Feedback",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        )));
  }
}
