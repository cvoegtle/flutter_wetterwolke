import 'package:flutter/cupertino.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';
import 'package:flutter_wetterwolke/formatter.dart';

class StatisticsViewer extends StatelessWidget {
  final TextStyle firstColumnStyle = TextStyle(fontWeight: FontWeight.bold);
  final TextStyle columnStyle = TextStyle(fontWeight: FontWeight.normal);

  final Statistics statistics;
  List<Widget> widgets = [];

  StatisticsViewer(this.statistics) {
    if (this.statistics != null) {
      addDefaultColumns();
      addSolarColumns(this.statistics.range);
    } else {
      widgets.add(Text("Einen Moment noch"));
    }
  }

  void addDefaultColumns() {
    widgets.add(firstColumn(this.statistics.range));
    widgets.add(columnRain(this.statistics.range));
    widgets.add(columnMinTemperature(this.statistics.range));
    widgets.add(columnMaxTemperature(this.statistics.range));
  }

  void addSolarColumns(List<StatisticsSet> range) {
    if (this.statistics.containsSolarInformation()) {
      widgets.add(columnSolarSum("∑ Sonne", range));
      widgets.add(columnSolarMax(range));
    } else if (this.statistics.containsPowerInformation()) {
      widgets.add(columnSolarSum("∑ KWh", range));
      widgets.add(columnPowerMax(range));
    } else if (this.statistics.containsCollectedEnergy()) {
      widgets.add(columnSolarSum("∑ kWh", range));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget firstColumn(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, ""));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(firstColumnStyle, mapRange(set.range)));
    }
    return StatisticsColumn(cells, crossAxisAlignment: CrossAxisAlignment.start,);
  }

  Widget columnRain(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, "Rain"));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(columnStyle, format(set.rain, postfix: "l")));
    }
    return StatisticsColumn(cells);
  }

  Widget columnMinTemperature(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, "T min"));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(
          columnStyle, format(set.minTemperature, postfix: "°C")));
    }
    return StatisticsColumn(cells);
  }

  Widget columnMaxTemperature(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, "T max"));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(
          columnStyle, format(set.maxTemperature, postfix: "°C")));
    }
    return new StatisticsColumn(cells);
  }

  Widget columnSolarSum(String caption, List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, caption));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(columnStyle, format(set.kwh, postfix: "kWh")));
    }
    return new StatisticsColumn(cells);
  }

  Widget columnSolarMax(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, "Max Sonne"));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(
          columnStyle, format(set.solarRadiationMax, postfix: "W/m²")));
    }
    return new StatisticsColumn(cells);
  }

  Widget columnPowerMax(List<StatisticsSet> range) {
    List<Widget> cells = [];
    cells.add(StatisticsCell(firstColumnStyle, "Maximum"));
    for (StatisticsSet set in statistics.range) {
      cells.add(StatisticsCell(
          columnStyle, format(set.solarRadiationMax, postfix: "W")));
    }
    return new StatisticsColumn(cells);
  }
}

class StatisticsColumn extends StatelessWidget {
  final List<Widget> cells;
  final EdgeInsetsGeometry padding = EdgeInsets.only(right: 10.0);
  final CrossAxisAlignment crossAxisAlignment;

  StatisticsColumn(this.cells, {this.crossAxisAlignment = CrossAxisAlignment.end});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
        child: Column(
            children: cells, crossAxisAlignment: crossAxisAlignment));
  }
}

class StatisticsCell extends StatelessWidget {
  final TextStyle style;
  final String value;

  const StatisticsCell(this.style, this.value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: Text(value, style: style));
  }
}
