import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Wetter Wolke Info")),
        body: Container(
          padding: EdgeInsets.all(8),
            child: Center(
            child: Column(children: [
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                        "Diese App ist eine Technologie-Demo für Cross Plattform Entwicklung mit ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "Flutter",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("https://flutter.dev");
                          }),
                    TextSpan(
                        text: ". Die App kann im Appstore für ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "iOS",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                "https://apps.apple.com/de/app/wetter-wolke/id1477964849");
                          }),
                    TextSpan(text: " und im Google Playstore für ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "Android",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                "https://play.google.com/store/apps/details?id=org.voegtle.weatherwidget");
                          }),
                    TextSpan(
                        text: " geladen werden.",
                        style: TextStyle(color: Colors.black)),
                  ])),
              Text(""),
              Text(
                  "Wetter Wolke ist ein Netz privater Wetterstationen in Deutschland mit einer Außenstelle in Shenzhen."),

            ]))));
  }
}
