import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

class PhysioPage extends StatelessWidget {
  const PhysioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(height: 40),
          const SizedBox(
            width: 300,
            height: 50,
            child: Text(
              'Physio',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.feedback, unknown: false, pageIndex: 3);
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Feedback'),
                ),
              )),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.silhouette, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Schmerz-Silhouette'),
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
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.groupStatistics, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Gruppen-Statistik'),
                ),
              )),
          Container(height: 40),
        ],
      ),
    );
  }
}
