import 'package:body_part_selector/body_part_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../providers/page_notifier.dart';

class SilhouettePage extends StatefulWidget {
  const SilhouettePage({required this.title, super.key});

  final String title;

  @override
  State<SilhouettePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SilhouettePage> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Schmerz-Silhouette'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              notifier.changePage(
                  page: PageName.home, unknown: false, pageIndex: 1);
            },
          ),
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