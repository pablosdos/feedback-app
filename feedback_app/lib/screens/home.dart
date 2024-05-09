import 'package:flutter/material.dart';
import 'package:feedback_app/core/api_client.dart';
import 'package:feedback_app/screens/login.dart';
import 'package:feedback_app/screens/personal_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feedback_app/data/price_point.dart';

class HomeScreen extends StatefulWidget {
  final double _currentSliderValueMotivation;
  final double _currentSliderValueMuskulaereErschoepfung;
  final double _currentSliderValueKoerperlicheEinschraenkung;
  final double _currentSliderValueSchlaf;
  final double _currentSliderValueStress;

  const HomeScreen(
      this._currentSliderValueMotivation,
      this._currentSliderValueMuskulaereErschoepfung,
      this._currentSliderValueKoerperlicheEinschraenkung,
      this._currentSliderValueSchlaf,
      this._currentSliderValueStress,
      {Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController motivationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();
  String _email = '';

  double _currentSliderValueMotivation = 3;
  double _currentSliderValueMuskulaereErschoepfung = 3;
  double _currentSliderValueKoerperlicheEinschraenkung = 3;
  double _currentSliderValueSchlaf = 3;
  double _currentSliderValueStress = 3;

  @override
  void initState() {
    _currentSliderValueMotivation = widget._currentSliderValueMotivation;
    _currentSliderValueMuskulaereErschoepfung =
        widget._currentSliderValueMuskulaereErschoepfung;
    _currentSliderValueKoerperlicheEinschraenkung =
        widget._currentSliderValueKoerperlicheEinschraenkung;
    _currentSliderValueSchlaf = widget._currentSliderValueSchlaf;
    _currentSliderValueStress = widget._currentSliderValueStress;
    super.initState();
    _loadPreferences();
    // _getInitialDataForFeedbackForm();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    debugPrint('prefs: $prefs');
    debugPrint('logout: $_email');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<void> submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Danke für die Eingabe'),
        backgroundColor: Colors.green.shade300,
      ));

      dynamic res = await _apiClient.submitFeedbackToDatabase(
        _email,
        _currentSliderValueMotivation.round().toString(),
        _currentSliderValueMuskulaereErschoepfung.round().toString(),
        _currentSliderValueKoerperlicheEinschraenkung.round().toString(),
        _currentSliderValueSchlaf.round().toString(),
        _currentSliderValueStress.round().toString(),
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['ErrorCode'] == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LineChartWidget(
                    motivationPoints,
                    muskulaereErschoepfungPoints,
                    koerperlicheEinschraenkungPoints,
                    schlafPoints,
                    stressPoints,
                    isComplete)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body: Form(
          key: _formKey,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          // SizedBox(height: size.height * 0.08),
                          const Center(
                            child: Text(
                              "Dein Feedback",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          Slider(
                              value: _currentSliderValueMotivation,
                              max: 5,
                              divisions: 5,
                              label:
                                  "Motivation: ${(_currentSliderValueMotivation.round()).toString()}",
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValueMotivation = value;
                                });
                              }),
                          Slider(
                              value: _currentSliderValueMuskulaereErschoepfung,
                              max: 5,
                              divisions: 5,
                              label:
                                  "Muskuläre Erschöpfung: ${(_currentSliderValueMuskulaereErschoepfung.round()).toString()}",
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValueMuskulaereErschoepfung =
                                      value;
                                });
                              }),
                          Slider(
                              value:
                                  _currentSliderValueKoerperlicheEinschraenkung,
                              max: 5,
                              divisions: 5,
                              label:
                                  "Koerperliche Einschränkung: ${(_currentSliderValueKoerperlicheEinschraenkung.round()).toString()}",
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValueKoerperlicheEinschraenkung =
                                      value;
                                });
                              }),
                          Slider(
                              value: _currentSliderValueSchlaf,
                              max: 5,
                              divisions: 5,
                              label:
                                  "Schlaf: ${(_currentSliderValueSchlaf.round()).toString()}",
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValueSchlaf = value;
                                });
                              }),
                          Slider(
                              value: _currentSliderValueStress,
                              max: 5,
                              divisions: 5,
                              label:
                                  "Stress: ${(_currentSliderValueStress.round()).toString()}",
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValueStress = value;
                                });
                              }),
                          TextButton(
                            onPressed: submitFeedback,
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.greenAccent.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25)),
                            child: const Text(
                              'Absenden',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          TextButton(
                            onPressed: logout,
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
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
}
