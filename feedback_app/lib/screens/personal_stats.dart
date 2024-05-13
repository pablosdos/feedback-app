import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:feedback_app/screens/home.dart';
import 'package:feedback_app/screens/team_stats.dart';
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

    Future<void> openTeamScreen() async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LineChartWidgetTeam(
                  motivationPoints,
                  muskulaereErschoepfungPoints,
                  koerperlicheEinschraenkungPoints,
                  schlafPoints,
                  stressPoints,
                  isComplete)));
    }

    var size = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // List<int> intList = [1, 2, 3];
    var intList = new Map();
    intList['Usrname'] = 'admin';
    intList['Password'] = 'admin@123';
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body: Form(
          key: _formKey,
          child: FutureBuilder(
            future: feedbacksAndCompleteHint(),
            initialData: "Code sample",
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An ${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  var validListMotivation = <PricePoint>[];
                  data["mapOfFeedbacks"]["motivation"]
                      .forEach((feedbacksMotivation) {
                    validListMotivation.add(feedbacksMotivation);
                  });
                  var validListmuskulaere_erschoepfung = <PricePoint>[];
                  data["mapOfFeedbacks"]["muskulaere_erschoepfung"]
                      .forEach((feedbacksmuskulaere_erschoepfung) {
                    validListmuskulaere_erschoepfung
                        .add(feedbacksmuskulaere_erschoepfung);
                  });
                  var validListkoerperliche_einschraenkung = <PricePoint>[];
                  data["mapOfFeedbacks"]["koerperliche_einschraenkung"]
                      .forEach((feedbackskoerperliche_einschraenkung) {
                    validListkoerperliche_einschraenkung
                        .add(feedbackskoerperliche_einschraenkung);
                  });
                  var validListschlaf = <PricePoint>[];
                  data["mapOfFeedbacks"]["schlaf"].forEach((feedbacksschlaf) {
                    validListschlaf.add(feedbacksschlaf);
                  });
                  var validListstress = <PricePoint>[];
                  data["mapOfFeedbacks"]["stress"].forEach((feedbacksstress) {
                    validListstress.add(feedbacksstress);
                  });
                  /*
                  if THERE IS
                  7 days
                  of continous
                  feedback
                  submission
                  */
                  if (data["isComplete"] == true) {
                    return Stack(children: [
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
                                    // for (int k = 0;
                                    //     k < data["mapOfFeedbacks"].length;
                                    //     k++)
                                    Stack(
                                      children: <Widget>[
                                        /*
                                          GRAPHS
                                          */
                                        SizedBox(height: size.height * 0.06),
                                        const Center(
                                          child: Text(
                                            "Deine 7-Tage-Statistik – Motivation",
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
                                                    spots: validListMotivation
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
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.06),
                                      ],
                                    ),
                                     SizedBox(height: size.height * 0.06),
                                    Stack(
                                      children: <Widget>[
                                        /*
                                          GRAPHS
                                          */
                                        SizedBox(height: size.height * 0.06),
                                        const Center(
                                          child: Text(
                                            "Muskulaere Erschöpfung",
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
                                                        validListmuskulaere_erschoepfung
                                                            .map((point) =>
                                                                FlSpot(point.x,
                                                                    point.y))
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
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.06),
                                      ],
                                    ),
                                     SizedBox(height: size.height * 0.06),
                                    Stack(
                                      children: <Widget>[
                                        /*
                                          GRAPHS
                                          */
                                        SizedBox(height: size.height * 0.06),
                                        const Center(
                                          child: Text(
                                            "Koerperliche Einschränkung",
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
                                                        validListkoerperliche_einschraenkung
                                                            .map((point) =>
                                                                FlSpot(point.x,
                                                                    point.y))
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
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.06),
                                      ],
                                    ),
                                     SizedBox(height: size.height * 0.04),
                                    Stack(
                                      children: <Widget>[
                                        /*
                                          GRAPHS
                                          */
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
                                                    spots: validListschlaf
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
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.06),
                                      ],
                                    ),
                                     SizedBox(height: size.height * 0.06),
                                    Stack(
                                      children: <Widget>[
                                        /*
                                          GRAPHS
                                          */
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
                                                    spots: validListstress
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
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.06),
                                      ],
                                    ),
                                     SizedBox(height: size.height * 0.06),
                                    /*
                                    BUTTONS
                                    */
                                    SizedBox(height: size.height * 0.02),
                                    TextButton(
                                      onPressed: () {
                                        HomeScreen passedHomeScreen =
                                            HomeScreen(2, 2, 2, 2, 2);
                                        if (data["todaysFeedback"].isNotEmpty) {
                                          passedHomeScreen = HomeScreen(
                                            data["todaysFeedback"][0]
                                                .motivation
                                                .toDouble(),
                                            data["todaysFeedback"][0]
                                                .muskulaere_erschoepfung
                                                .toDouble(),
                                            data["todaysFeedback"][0]
                                                .koerperliche_einschraenkung
                                                .toDouble(),
                                            data["todaysFeedback"][0]
                                                .schlaf
                                                .toDouble(),
                                            data["todaysFeedback"][0]
                                                .stress
                                                .toDouble(),
                                          );
                                        }
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    passedHomeScreen));
                                      },
                                      style: TextButton.styleFrom(
                                          minimumSize:
                                              Size(double.infinity, 50),
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
                                    SizedBox(height: size.height * 0.01),
                                    if (data["group_name"] != '')
                                      TextButton(
                                        onPressed: openTeamScreen,
                                        style: TextButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 50),
                                            backgroundColor:
                                                Colors.blueAccent.shade700,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 25)),
                                        child: const Text(
                                          'Team-Statistik',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    SizedBox(height: size.height * 0.04),
                                    TextButton(
                                      onPressed: logout,
                                      style: TextButton.styleFrom(
                                          minimumSize:
                                              Size(double.infinity, 50),
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
                    ]);
                  }
                  /*
                  if there is
                  NOT 7 days
                  of continous
                  feedback
                  submission
                  */
                  return Stack(children: [
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
                                  SizedBox(height: size.height * 0.02),
                                  const Center(
                                      child: Text(
                                    "Vielen Dank für deine Eingabe. Ist für 7 aufeinander folgende Tage Feedback eingereicht, dann ist die Statistik hier einsehbar.",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  SizedBox(height: size.height * 0.04),
                                  TextButton(
                                    onPressed: () {
                                      HomeScreen passedHomeScreen =
                                          HomeScreen(2, 2, 2, 2, 2);
                                      if (data["todaysFeedback"].isNotEmpty) {
                                        passedHomeScreen = HomeScreen(
                                          data["todaysFeedback"][0]
                                              .motivation
                                              .toDouble(),
                                          data["todaysFeedback"][0]
                                              .muskulaere_erschoepfung
                                              .toDouble(),
                                          data["todaysFeedback"][0]
                                              .koerperliche_einschraenkung
                                              .toDouble(),
                                          data["todaysFeedback"][0]
                                              .schlaf
                                              .toDouble(),
                                          data["todaysFeedback"][0]
                                              .stress
                                              .toDouble(),
                                        );
                                      }
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  passedHomeScreen));
                                    },
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(double.infinity, 50),
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
                                  SizedBox(height: size.height * 0.01),
                                  TextButton(
                                    onPressed: openTeamScreen,
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(double.infinity, 50),
                                        backgroundColor:
                                            Colors.blueAccent.shade700,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25)),
                                    child: const Text(
                                      'Team-Statistik',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  TextButton(
                                    onPressed: logout,
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(double.infinity, 50),
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
                  ]);
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
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
