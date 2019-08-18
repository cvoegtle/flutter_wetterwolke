
import 'package:flutter/cupertino.dart';
import 'package:flutter_wetterwolke/data/statistics.dart';

class StatisticsViewer extends StatelessWidget {
  final Statistics statistics;
  String text; 
  
  StatisticsViewer(this.statistics) {
    if (this.statistics != null) {
      text = statistics.id;
    } else {
      text = "Einen Moment noch";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
  
}