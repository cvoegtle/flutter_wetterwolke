import 'package:flutter/cupertino.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';

class StatisticsViewer extends StatelessWidget {
  List<String> columns = ["", "Regen", "T min", "T max"];
  List<String> solarColumns = ["∑ Sonne", "Max Sonne"];
  final Statistics statistics;
  List<Widget> widgets = [];

  StatisticsViewer(this.statistics) {
    if (this.statistics != null) {
      if (this.statistics.containsSolarInformation()) {
        columns.addAll(solarColumns);
      }
      widgets.add(HeaderRow(columns));
      for (StatisticsSet stats in statistics.range) {
        widgets.add(StatisticsRow(formatStatisticsSet(stats)));
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
  TextStyle columnStyle = TextStyle(fontWeight: FontWeight.normal); 
  List<Widget> cells = [];
  
  StatisticsRow(List<String> text) {
    if (text.length > 0) {
      cells.add(StatisticsCell(firstColumn, _column_width[0], text[0], textAlign: TextAlign.left,));
    }

    for (var i = 1; i < text.length; i++) {
      cells.add(StatisticsCell(columnStyle, _column_width[i], text[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: cells);
  }
}

class HeaderRow extends StatisticsRow {
  TextStyle columnStyle = TextStyle(fontWeight: FontWeight.bold);

  HeaderRow(List<String> text) : super(text);
  
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
