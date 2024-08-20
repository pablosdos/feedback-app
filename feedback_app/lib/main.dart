import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../enums.dart';
import 'providers/page_notifier.dart';
import '../pages/home.dart';
import 'pages/info.dart';
import 'pages/physio.dart';
import 'pages/physio_pages/silhouette.dart';
import 'pages/info_pages/about.dart';
import 'pages/info_pages/agb.dart';
import 'pages/info_pages/app.dart';
import 'pages/info_pages/disclaimer.dart';
import 'pages/info_pages/impress.dart';
import 'pages/onboarding_pages/login.dart';
import 'pages/onboarding_pages/start.dart';
import 'pages/physio_pages/feedback.dart';
import 'pages/physio_pages/feedback_received.dart';
import 'pages/physio_pages/statistics.dart';
import 'pages/physio_pages/groupStatistics.dart';

/// Flutter code sample for [NavigationBar].

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  runApp(NavigationBarApp(
    emailInApp: prefs.getString('email'),
  ));
}

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({required this.emailInApp, super.key});

  final String? emailInApp;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PageNotifier(),
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: NavigationExample(emailInNavigationExample: emailInApp),
        ));
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({required this.emailInNavigationExample, super.key});

  final String? emailInNavigationExample;

  @override
  State<NavigationExample> createState() =>
      _NavigationExampleState(emailInNavigationExample);
}

class _NavigationExampleState extends State<NavigationExample> {
  String? emailInNavigationExampleState;

  _NavigationExampleState(this.emailInNavigationExampleState);

  @override
  void initState() {
    emailInNavigationExampleState = emailInNavigationExampleState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    final ThemeData theme = Theme.of(context);
    // route to the page; Sub Pages
    // debugPrint(emailInNavigationExampleState);
    // debugPrint(notifier.pageName.toString());
    if (emailInNavigationExampleState == null &&
        notifier.pageName != PageName.login) {
      return const StartPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.silhouette) {
      return const SilhouettePage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.feedback) {
      return const HomeScreen(2, 2, 2, 2, 2);
    } else if (notifier.pageName == PageName.feedbackReceived) {
      return const FeedbackReceivedPage(title: 'xyz');
    } else if (notifier.pageName == PageName.statistcs) {
      return const StatisticsPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.groupStatistics) {
      return const GroupStatisticsPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.login) {
      return const LoginPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.onboarding) {
      return const StartPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.about) {
      return const AboutPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.agb) {
      return const AgbPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.app) {
      return const AppPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.disclaimer) {
      return const DisclaimerPage(title: 'Schmerz-Silhouette');
    } else if (notifier.pageName == PageName.impress) {
      return const ImpressPage(title: 'Schmerz-Silhouette');
    } else {
      // route to the page; Home Page
      return Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              notifier.changePage(
                  page: PageName.home, unknown: false, pageIndex: index);
            },
            indicatorColor: Colors.amber,
            selectedIndex: notifier.currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Start',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.health_and_safety),
                icon: Icon(Icons.health_and_safety_outlined),
                label: 'Physio',
              ),
              NavigationDestination(
                selectedIcon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.calendar_month),
                ),
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.calendar_month_outlined),
                ),
                label: 'Kalender',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.info),
                icon: Icon(Icons.info_outlined),
                label: 'Info',
              ),
            ],
          ),
          body: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  notifier.currentPageIndex == 0
                      ? SliverAppBar(
                          expandedHeight: 200.0,
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              title: SafeArea(
                                child: Container(
                                  alignment: Alignment.center,

                                  // we can set width here with conditions
                                  width: 200,
                                  child: const Text(
                                    """Hallo Max, \nkooperiere mit deinem Staff! Hilf Ihnen sich ein 
umfassendes Bild über deine Wahrnehmung
zu schaffen, indem du dein Feedback über 
deine Wahrnehmung teilst.""",
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                ),
                              ),
                              background: Image.network(
                                "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                                fit: BoxFit.cover,
                              )),
                        )
                      : SliverAppBar(
                          floating: false,
                          pinned: true,
                          flexibleSpace: SafeArea(
                            child: Container(
                              alignment: Alignment.center,

                              // we can set width here with conditions
                              width: 200,
                              child: const Text(
                                """Info""",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        )
                ];
              },
              body: Center(
                child: SingleChildScrollView(
                  child: Center(
                      child: Stack(
                    children: [
                      <Widget>[
                        const HomePage(),
                        PhysioPage(),
                        const Card(
                          shadowColor: Colors.transparent,
                          margin: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text(
                              "Feedback Kalender",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ),
                        const InfoPage(),
                      ][notifier.currentPageIndex],
                    ],
                  )),
                ),
              ),
            ),
          ));
    }
  }
}
