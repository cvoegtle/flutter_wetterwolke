import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';

class DiagramPage extends StatelessWidget {
  final String title;
  final List<DiagramConfiguration> diagrams;

  const DiagramPage(this.title, this.diagrams);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
            child: DiagramViewer(diagrams)));
  }
}

class DiagramViewer extends StatelessWidget {
  final List<DiagramConfiguration> diagrams;

  const DiagramViewer(this.diagrams);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(
      viewportFraction: 1.0,
      items: diagrams.map((diagram) => Image.network(diagram.url)).toList(),
    );
  }

}
