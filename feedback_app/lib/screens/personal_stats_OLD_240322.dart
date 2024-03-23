// import 'dart:ui';
// import 'package:feedback_app/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:feedback_app/screens/home.dart';
// import 'package:feedback_app/core/api_client.dart';
// import 'package:feedback_app/screens/home.dart';
// import 'package:feedback_app/screens/personal_stats.dart';
// import 'package:feedback_app/utils/validator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:feedback_app/data/price_point.dart';

// class PersonalStatsScreen extends StatefulWidget {
//   @override
//   State<PersonalStatsScreen> createState() => _PersonalStatsScreenState();
// }

// class _PersonalStatsScreenState extends State<PersonalStatsScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String _email = '';
//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//   }

//   void _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _email = prefs.getString('email') ?? '';
//     });
//     debugPrint('enter personal stats screen with: $_email');
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('email');
//     debugPrint('prefs: $prefs');
//     debugPrint('logout: $_email');
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const LoginScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.blueGrey[200],
//         body: Form(
//           key: _formKey,
//           child: Stack(children: [
//             SizedBox(
//               width: size.width,
//               height: size.height,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   width: size.width * 0.85,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           // SizedBox(height: size.height * 0.08),
//                           const Center(
//                             child: Text(
//                               "Deine 7-Tage-Statistik",
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: size.height * 0.06),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LineChartWidget(pricePoints)));
//                             },
//                             style: TextButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent.shade700,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 25)),
//                             child: const Text(
//                               'Statistik',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => HomeScreen()));
//                             },
//                             style: TextButton.styleFrom(
//                                 backgroundColor: Colors.greenAccent.shade700,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 25)),
//                             child: const Text(
//                               'Heutiges Feedback ändern',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                           SizedBox(height: size.height * 0.04),
//                           TextButton(
//                             onPressed: logout,
//                             style: TextButton.styleFrom(
//                                 backgroundColor: Colors.redAccent.shade700,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 25)),
//                             child: const Text(
//                               'Logout',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ));
//   }
// }
