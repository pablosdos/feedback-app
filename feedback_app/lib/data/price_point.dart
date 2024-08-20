import 'package:collection/collection.dart';
import 'package:coopmetrics/core/api_client.dart';

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
  final motivationNumbers = <double>[];
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
  final muskulaereErschoepfungnumbers = <double>[];
  final koerperlicheEinschraenkungnumbers = <double>[];
  final schlafNumbers = <double>[];
  final stressNumbers = <double>[];

  for (var i = 0; i < result.length; i++) {
    for (var j = 0; j < lastSevenDays.length; j++) {
      if (result[i].created_at.toString().substring(0, 10) ==
          lastSevenDays[j].toString().substring(0, 10)) {
        motivationNumbers.add(result[i].motivation.toDouble());
        muskulaereErschoepfungnumbers
            .add(result[i].muskulaere_erschoepfung.toDouble());
        koerperlicheEinschraenkungnumbers
            .add(result[i].koerperliche_einschraenkung.toDouble());
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
      muskulaereErschoepfungnumbers
          .mapIndexed(
              (index, element) => PricePoint(x: index.toDouble(), y: element))
          .toList();
  mapOfPricePointLists['koerperliche_einschraenkung'] =
      koerperlicheEinschraenkungnumbers
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
  var bundle = {};
  var result = await _apiClient.getFeedbacks();
  var resultTodaysFeedback = await _apiClient.getFeedbackOfToday();
  bundle['isComplete'] = getIsComplete(result);
  bundle['mapOfFeedbacks'] = getMapOfPricePointLists(result);
  bundle['todaysFeedback'] = resultTodaysFeedback;
  try {
    bundle['group_name'] = result[0].group_of_user.toString();
  } catch (e) {
    // code that handles the exception
  }
  return bundle;
}

Future feedbacksAndCompleteHintOfGroup() async {
  var bundle = {};
  var result = await _apiClient.getFeedbacksOfGroup();
  var resultTodaysFeedback = await _apiClient.getFeedbackOfToday();
  bundle['isComplete'] = getIsComplete(result);
  bundle['mapOfFeedbacks'] = getMapOfPricePointLists(result);
  bundle['todaysFeedback'] = resultTodaysFeedback;
  try {
    bundle['group_name'] = result[0].group_of_user.toString();
  } catch (e) {
    // code that handles the exception
  }
  return bundle;
}

bool get isComplete {
  return true;
}
