import 'package:intl/intl.dart';

const String DEFAULT_LOCALE = "de_DE";
final defaultFormatter = NumberFormat("#,###.#", DEFAULT_LOCALE);

String format(num value, {String prefix = "", String postfix = ""}) {
  String formattedNumber = "";

  if (value != null) {
    formattedNumber = prefix;
    formattedNumber += defaultFormatter.format(value);
    formattedNumber += postfix;
  }

  return  formattedNumber;
}
