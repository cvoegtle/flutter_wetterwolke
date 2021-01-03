import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Wetter Wolke")),
        body: Container(
            padding: EdgeInsets.all(8),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Caption("Über das Projekt"),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "Diese App ist eine Technologie-Demo für Cross Plattform Entwicklung mit ",
                        style: TextStyle(color: Colors.black)),
                    Link("Flutter", "https://flutter.dev"),
                    TextSpan(
                        text: ". Die App kann im Appstore für ",
                        style: TextStyle(color: Colors.black)),
                    Link("iOS",
                        "https://apps.apple.com/de/app/wetter-wolke/id1477964849"),
                    TextSpan(
                        text: " und im Google Playstore für ",
                        style: TextStyle(color: Colors.black)),
                    Link("Android",
                        "https://play.google.com/store/apps/details?id=org.voegtle.weatherwidget"),
                    TextSpan(
                        text: " geladen werden.",
                        style: TextStyle(color: Colors.black)),
                  ])),
                  Text(""),
                  Text(
                      "Wetter Wolke ist ein Netz privater Wetterstationen in Deutschland mit einer Außenstelle in Shenzhen."),
                  Divider(),
                  Caption("Kontakt"),
                  Text("Projekt bei Github"),
                  RichText(
                      text: Link(
                          "https://github.com/cvoegtle/flutter_wetterwolke",
                          "https://github.com/cvoegtle/flutter_wetterwolke")),
                  Text("Mail an Entwickler"),
                  RichText(
                      text: Link("christian@voegtle.org",
                          "mailto:christian@voegtle.org")),
                  Text("Hilfe und Support"),
                      RichText(
                          text: Link(
                              "Bedienungshinweise online",
                              "https://github.com/cvoegtle/flutter_wetterwolke/blob/master/HELP.md")),
                  Divider(),
                  Caption("Versions Information"),
                  Text("Version 1.16.26-26 vom 3.1.2021 ")
                ]))));
  }
}

class Caption extends StatelessWidget {
  final String text;

  Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.orange)),
      padding: EdgeInsets.only(bottom: 5),
    );
  }
}

class Link extends TextSpan {
  Link(String text, String url)
      : super(
            text: text,
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(url);
              });
}
