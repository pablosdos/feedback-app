import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(height: 40),
        const SizedBox(
          width: 300,
          height: 50,
          child: Text(
            "Überblick",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Card(
          // Define the shape of the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          // Define how the card's content should be clipped
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // Define the child widget of the card
          child: SizedBox(
            width: 350,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add padding around the row widget
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/images/feedback-smileys.png',
                                height: 100,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Container(width: 20),
                            Center(
                                child: Text(
                              'zum Feedback',
                              style: MyTextSample.title(context)!.copyWith(
                                color: MyColorsSample.grey_80,
                              ),
                            )),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),
                            // Add a subtitle widget
                            Center(
                                child: Text(
                              "Tages-Feedback",
                              style: MyTextSample.body1(context)!.copyWith(
                                color: Colors.grey[500],
                              ),
                            )),
                            // Add some spacing between the subtitle and the text
                            Container(height: 10),
                            // Add a text widget to display some text
                            Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              MyStringsSample.card_text,
                              maxLines: 4,
                              style: MyTextSample.subhead(context)!.copyWith(
                                color: Colors.grey[700],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 40),
        InkWell(
          onTap: () {
            notifier.changePage(
                page: PageName.silhouette, unknown: false, pageIndex: 3);
          },
          child: Card(
            // Define the shape of the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // Define how the card's content should be clipped
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widget of the card
            child: SizedBox(
              width: 350,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Add padding around the row widget
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/Feedback_Silhouette.jpg',
                                  height: 150,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Container(width: 40),
                              Center(
                                  child: Text(
                                "Schmerz-Silhouette",
                                style: MyTextSample.title(context)!.copyWith(
                                  color: MyColorsSample.grey_80,
                                ),
                              )),
                              // Add some spacing between the title and the subtitle
                              Container(height: 5),
                              // Add a subtitle widget
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(height: 40),
        const SizedBox(
          width: 300,
          height: 50,
          child: Text(
            "Dein Kalender",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Card(
          // Define the shape of the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          // Define how the card's content should be clipped
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // Define the child widget of the card
          child: SizedBox(
            width: 350,
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add padding around the row widget
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/images/kalender.png',
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Container(width: 20),
                            Center(
                                child: Text(
                              "Feedback-Übersicht",
                              style: MyTextSample.title(context)!.copyWith(
                                color: MyColorsSample.grey_80,
                              ),
                            )),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),

                            // Add some spacing between the subtitle and the text
                            Container(height: 10),
                            // Add a text widget to display some text
                            Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              "Entdecke, an welchen Tagen du bereits dein Feedback abgegeben hast. Du hast an den letzten ${notifier.currentPageIndex} Tagen erfolgreich mit deinem Staff kooperiert.",
                              maxLines: 4,
                              style: MyTextSample.subhead(context)!.copyWith(
                                color: Colors.grey[700],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}

class ImgSample {
  static String get(String name) {
    return 'assets/images/$name';
  }
}

class MyTextSample {
  static TextStyle? display4(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge;
  }

  static TextStyle? display3(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium;
  }

  static TextStyle? display2(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall;
  }

  static TextStyle? display1(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  static TextStyle? headline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18,
        );
  }

  static TextStyle? subhead(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle? body2(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge;
  }

  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  static TextStyle? caption(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(letterSpacing: 1);
  }

  static TextStyle? subtitle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall;
  }

  static TextStyle? overline(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall;
  }
}

class MyStringsSample {
  static const String lorem_ipsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin"
      "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin";
  static const String middle_lorem_ipsum =
      "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.";
  static const String card_text =
      "Nutze dieses Feature täglich, um deine Wahrnehmung zu schulen und dich besser selbst einschätzen zu können.";
}

class MyColorsSample {
  static const Color primary = Color(0xFF12376F);
  static const Color primaryDark = Color(0xFF0C44A3);
  static const Color primaryLight = Color(0xFF43A3F3);
  static const Color green = Colors.green;
  static Color black = const Color(0xFF000000);
  static const Color accent = Color(0xFFFF4081);
  static const Color accentDark = Color(0xFFF50057);
  static const Color accentLight = Color(0xFFFF80AB);
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);
  static const Color transparent = Color(0x00f7f7f7);
}
