import 'package:body_part_selector/body_part_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../providers/page_notifier.dart';

class FeedbackReceivedPage extends StatefulWidget {
  const FeedbackReceivedPage({required this.title, super.key});

  final String title;

  @override
  State<FeedbackReceivedPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FeedbackReceivedPage> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Danke für dein Feedback'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              notifier.changePage(
                  page: PageName.home, unknown: false, pageIndex: 1);
            },
          ),
        ),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(height: 40),
          const SizedBox(
            width: 300,
            height: 50,
            child: Text(
              '',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.home, unknown: false, pageIndex: 0);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Okay'),
                ),
              )),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.statistcs, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Statistik'),
                ),
              )),
        
        ],
      ),
    )
        );
  }
}
