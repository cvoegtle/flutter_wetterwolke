import 'package:flutter/cupertino.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';

class StatisticsViewer extends StatelessWidget {
  final Statistics statistics;
  List<Widget> widgets = [];

  StatisticsViewer(this.statistics) {
    if (this.statistics != null) {
      widgets.add(StatisticsRow(true, ["", "Regen", "T min", "T max", "∑ Sonne", "Max Sonne"]));
      for (StatisticsSet stats in statistics.range) {
        widgets.add(StatisticsRow(false, formatStatisticsSet(stats)));
      }
    } else {
      widgets.add(Text("Einen Moment noch"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: widgets);
  }
}

class StatisticsRow extends StatelessWidget {
  static const _column_width = [65.0, 50.0, 50.0, 50.0, 70.0, 80.0];
  TextStyle firstColumn = TextStyle(fontWeight: FontWeight.bold);
  List<Widget> cells = [];
  
  StatisticsRow(bool isCaption, List<String> text) {
    if (text.length > 0) {
      cells.add(StatisticsCell(firstColumn, _column_width[0], text[0], textAlign: TextAlign.left,));
    }

    var style = TextStyle(fontWeight: isCaption ? FontWeight.bold: FontWeight.normal);
    for (var i = 1; i < text.length; i++) {
      cells.add(StatisticsCell(style, _column_width[i], text[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: cells);
  }
}

class StatisticsCell extends StatelessWidget {
  final TextStyle style;
  final double width;
  final String value;
  final TextAlign textAlign;

  const StatisticsCell(this.style, this.width, this.value, {this.textAlign = TextAlign.right});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Text(value, style: style, textAlign: textAlign));
  }
  
}
