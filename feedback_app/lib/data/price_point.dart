import 'dart:math';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:feedback_app/core/api_client.dart';
import 'dart:developer' as logging;

final lastSevenDays = List<DateTime>.generate(
    7,
    (i) => DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).subtract(Duration(days: i)));

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}

final ApiClient _apiClient = ApiClient();

List<PricePoint> get motivationPoints {
  final Random random = Random();
  final motivationNumbers = <double>[];

  for (var i = 0; i <= 6; i++) {
    motivationNumbers.add(random.nextDouble());
  }
  // motivationNumbers.clear();
  // print('original');
  // print(motivationNumbers);
  // print(motivationNumbers
  //     .mapIndexed(
  //         (index, element) => PricePoint(x: index.toDouble(), y: element))
  //     .toList()[0].y);
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

List<PricePoint> get muskulaereErschoepfungPoints {
  final motivationNumbers = <double>[];
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

List<PricePoint> get koerperlicheEinschraenkungPoints {
  final motivationNumbers = <double>[];
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

List<PricePoint> get muskulaereErschoepfungPointsPoints {
  final motivationNumbers = <double>[];
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

List<PricePoint> get schlafPoints {
  final motivationNumbers = <double>[];
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

List<PricePoint> get stressPoints {
  final motivationNumbers = <double>[];
  return motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

bool getIsComplete(result) {
  int counter = 0;
  bool returnValue;
  for (var i = 0; i < result.length; i++) {
    for (var j = 0; j < lastSevenDays.length; j++) {
      if (result[i].created_at.toString().substring(0, 10) ==
          lastSevenDays[j].toString().substring(0, 10)) {
        // print(lastSevenDays[j].toString());
        counter++;
      }
    }
  }
  if (counter == 7) {
    returnValue = true;
  } else {
    returnValue = false;
  }
  return returnValue;
}

Map<String, List<PricePoint>> getMapOfPricePointLists(result) {
  int counter = 0;
  Map<String, List<PricePoint>> mapOfPricePointLists = {};
  final motivationNumbers = <double>[];
  final muskulaere_erschoepfungNumbers = <double>[];
  final koerperliche_einschraenkungNumbers = <double>[];
  final schlafNumbers = <double>[];
  final stressNumbers = <double>[];

  for (var i = 0; i < result.length; i++) {
    for (var j = 0; j < lastSevenDays.length; j++) {
      if (result[i].created_at.toString().substring(0, 10) ==
          lastSevenDays[j].toString().substring(0, 10)) {
        motivationNumbers.add(result[i].motivation.toDouble());
        muskulaere_erschoepfungNumbers.add(result[i].muskulaere_erschoepfung.toDouble());
        koerperliche_einschraenkungNumbers.add(result[i].koerperliche_einschraenkung.toDouble());
        schlafNumbers.add(result[i].schlaf.toDouble());
        stressNumbers.add(result[i].stress.toDouble());
        counter++;
      }
    }
  }

  mapOfPricePointLists['motivation'] = motivationNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
  mapOfPricePointLists['muskulaere_erschoepfung'] =
      muskulaere_erschoepfungNumbers
          .mapIndexed(
              (index, element) => PricePoint(x: index.toDouble(), y: element))
          .toList();
  mapOfPricePointLists['koerperliche_einschraenkung'] =
      koerperliche_einschraenkungNumbers
          .mapIndexed(
              (index, element) => PricePoint(x: index.toDouble(), y: element))
          .toList();
  mapOfPricePointLists['schlaf'] = schlafNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
  mapOfPricePointLists['stress'] = stressNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();

  return mapOfPricePointLists;
}

Future feedbacksAndCompleteHint() async {
  var bundle = new Map();
  var result = await _apiClient.getFeedbacks();
  bundle['isComplete'] = getIsComplete(result);
  bundle['mapOfFeedbacks'] = getMapOfPricePointLists(result);
  return bundle;
}

bool get isComplete {
  return true;
}
