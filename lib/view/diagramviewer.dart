import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wetterwolke/data/configuration.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DiagramPage extends StatelessWidget {
  final String title;
  final List<DiagramConfiguration> diagrams;

  const DiagramPage(this.title, this.diagrams);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: DiagramViewer(diagrams)));
  }
}

class DiagramPreviewer extends StatelessWidget {
  final String title;
  final List<DiagramConfiguration> diagrams;

  const DiagramPreviewer(this.title, this.diagrams);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.all(8), child: Image.network(appendTime(diagrams[0].url))),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DiagramPage(title, diagrams)));
        });
  }
}

class DiagramViewer extends StatelessWidget {
  final List<DiagramConfiguration> diagrams;

  const DiagramViewer(this.diagrams);

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(appendTime(diagrams[index].url)),
          initialScale: PhotoViewComputedScale.contained * 0.95,
          heroTag: diagrams[index].description,
        );
      },
      itemCount: diagrams.length,
    );
  }
}

String appendTime(String url) {
  String dateWithHour = new DateFormat("yyyy-mm-dd-h").format(DateTime.now());
  return url + "&" + dateWithHour;
}
