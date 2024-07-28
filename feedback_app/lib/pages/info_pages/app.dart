import 'package:body_part_selector/body_part_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../providers/page_notifier.dart';

class AppPage extends StatefulWidget {
  const AppPage({required this.title, super.key});

  final String title;

  @override
  State<AppPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppPage> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('App'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              notifier.changePage(
                  page: PageName.home, unknown: false, pageIndex: 3);
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
              "Version 1.2.0",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        )));
  }
}
