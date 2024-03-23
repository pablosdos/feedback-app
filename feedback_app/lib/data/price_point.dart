import 'dart:math';
import 'package:collection/collection.dart';
import 'package:feedback_app/core/api_client.dart';
import 'dart:developer' as logging;

final days = List<DateTime>.generate(
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
const json = '''
{
    "first_name": "",
    "last_name": "",
    "email": "",
    "password": "",
    "feedbacks": [
    ]
}
''';

Future<void> getFeedbacks() async {
  dynamic res = await _apiClient.getUserWithFeedbacks();
  logging.log(res["feedbacks"].toString());
}

List<PricePoint> get motivationPoints {
  final Random random = Random();
  final motivationNumbers = <double>[];
  getFeedbacks().then((value) {
    // print(value);
  });

  logging.log('data: $days');

  for (var i = 0; i < days.length; i++) {
    print(days[i]);
  }
  for (var i = 0; i <= 6; i++) {
    print(i);
    // TODO: get date of this day; try to find in feedback; if found, take value; otherwise
    // String a = random.nextDouble().toString();
    // logging.log('data: $a');
    motivationNumbers.add(random.nextDouble());
  }
  // motivationNumbers.clear();
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

bool get isComplete {
  return false;
}