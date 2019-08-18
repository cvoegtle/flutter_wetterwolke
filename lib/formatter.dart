import 'package:intl/intl.dart';

final defaultFormatter = NumberFormat("#,###.#");

String format(num value, {String prefix = "", String postfix = ""}) {
  String formattedNumber = "";

  if (value != null) {
    formattedNumber = prefix;
    formattedNumber += defaultFormatter.format(value);
    formattedNumber += postfix;
  }

  return  formattedNumber;
}