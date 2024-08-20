import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Future<void> logout(notifier) async {
    // final notifier = Provider.of<PageNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    notifier.changePage(
        page: PageName.onboarding, unknown: false, pageIndex: 3);
  }

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
              'Allgemein',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.about, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Über CoopMetrics'),
                ),
              )),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.app, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('App'),
                ),
              )),
          Container(height: 40),
          const SizedBox(
            width: 300,
            height: 50,
            child: Text(
              "Herausgeber",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.impress, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Impressum'),
                ),
              )),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.agb, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('AGB'),
                ),
              )),
          InkWell(
              onTap: () {
                notifier.changePage(
                    page: PageName.disclaimer, unknown: false, pageIndex: 3);
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text('Datenschutz'),
                ),
              )),
          Container(height: 40),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              logout(notifier);
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
