import 'package:flutter/material.dart';
import 'package:coopmetrics/screens/login.dart';
import 'package:coopmetrics/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  // debugPrint('email exists if visible: $email');
  await dotenv.load();
  runApp(MaterialApp(home: email == null ? LoginScreen() : HomeScreen(2, 2, 2, 2, 2)));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'LoginRadius Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }
