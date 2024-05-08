import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:feedback_app/screens/home.dart';
import 'package:feedback_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feedback_app/data/price_point.dart';
import 'package:intl/intl.dart';

class LineChartWidget extends StatelessWidget {
  final List<PricePoint> motivationPoints;
  final List<PricePoint> muskulaereErschoepfungPoints;
  final List<PricePoint> koerperlicheEinschraenkungPoints;
  final List<PricePoint> schlafPoints;
  final List<PricePoint> stressPoints;
  final bool isComplete;
  // String _email = '';
  const LineChartWidget(
      this.motivationPoints,
      this.muskulaereErschoepfungPoints,
      this.koerperlicheEinschraenkungPoints,
      this.schlafPoints,
      this.stressPoints,
      this.isComplete,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      debugPrint('prefs: $prefs');
      debugPrint('logout: $prefs.email');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    var size = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    debugPrint('motivationPoints');
    debugPrint(this.motivationPoints.toString());
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body: Form(
          key: _formKey,
          child: (isComplete == false)
              ? Stack(children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width * 0.85,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: size.height * 0.08),
                                const Center(
                                    child: Text(
                                  "Bitte lege für 7 aufeinander folgende Tage Feedback an, dann ist die Statistik hier einsehbar.",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.greenAccent.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25)),
                                  child: const Text(
                                    'Heutiges Feedback ändern',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.04),
                                TextButton(
                                  onPressed: logout,
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25)),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ])
              : Stack(children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width * 0.85,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: size.height * 0.08),
                                const Center(
                                  child: Text(
                                    "Deine 7-Tage-Statistik",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.06),
                                const Center(
                                  child: Text(
                                    "Motivation",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: LineChart(
                                    LineChartData(
                                      lineBarsData: [
                                        LineChartBarData(
                                            spots: motivationPoints
                                                .map((point) =>
                                                    FlSpot(point.x, point.y))
                                                .toList(),
                                            isCurved: false,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            color: Colors.red),
                                      ],
                                      borderData: FlBorderData(
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide())),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                            sideTitles: _bottomTitles),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.06),
                                SizedBox(height: size.height * 0.06),
                                const Center(
                                  child: Text(
                                    "Muskuläre Erschöpfung",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: LineChart(
                                    LineChartData(
                                      lineBarsData: [
                                        LineChartBarData(
                                            spots: muskulaereErschoepfungPoints
                                                .map((point) =>
                                                    FlSpot(point.x, point.y))
                                                .toList(),
                                            isCurved: false,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            color: Colors.red),
                                      ],
                                      borderData: FlBorderData(
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide())),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                            sideTitles: _bottomTitles),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.06),
                                SizedBox(height: size.height * 0.06),
                                const Center(
                                  child: Text(
                                    "Körperliche Einschränkung",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: LineChart(
                                    LineChartData(
                                      lineBarsData: [
                                        LineChartBarData(
                                            spots:
                                                koerperlicheEinschraenkungPoints
                                                    .map((point) => FlSpot(
                                                        point.x, point.y))
                                                    .toList(),
                                            isCurved: false,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            color: Colors.red),
                                      ],
                                      borderData: FlBorderData(
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide())),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                            sideTitles: _bottomTitles),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.06),
                                SizedBox(height: size.height * 0.06),
                                const Center(
                                  child: Text(
                                    "Schlaf",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: LineChart(
                                    LineChartData(
                                      lineBarsData: [
                                        LineChartBarData(
                                            spots: schlafPoints
                                                .map((point) =>
                                                    FlSpot(point.x, point.y))
                                                .toList(),
                                            isCurved: false,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            color: Colors.red),
                                      ],
                                      borderData: FlBorderData(
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide())),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                            sideTitles: _bottomTitles),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.06),
                                SizedBox(height: size.height * 0.06),
                                const Center(
                                  child: Text(
                                    "Stress",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: LineChart(
                                    LineChartData(
                                      lineBarsData: [
                                        LineChartBarData(
                                            spots: stressPoints
                                                .map((point) =>
                                                    FlSpot(point.x, point.y))
                                                .toList(),
                                            isCurved: false,
                                            dotData: FlDotData(
                                              show: false,
                                            ),
                                            color: Colors.red),
                                      ],
                                      borderData: FlBorderData(
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide())),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                            sideTitles: _bottomTitles),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.greenAccent.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25)),
                                  child: const Text(
                                    'Heutiges Feedback ändern',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.04),
                                TextButton(
                                  onPressed: logout,
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25)),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
        ));
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          DateTime date = DateTime.now();
          switch (value.toInt()) {
            case 0:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 6)))
                  .substring(0, 2);
              break;
            case 1:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 5)))
                  .substring(0, 2);
              break;
            case 2:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 4)))
                  .substring(0, 2);
              break;
            case 3:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 3)))
                  .substring(0, 2);
              break;
            case 4:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 2)))
                  .substring(0, 2);
              break;
            case 5:
              text = DateFormat('EEEE')
                  .format(date.subtract(Duration(days: 1)))
                  .substring(0, 2);
              break;
            case 6:
              text = DateFormat('EEEE').format(date).substring(0, 2);
              ;
              break;
          }
          return Text(text);
        },
      );
}
