import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/formatter.dart';

void main() {
  test('Kilometer', () {
    expect(format(12345.6789, postfix: "km"), "12,345.7km");
  });

  test('Kilometer mit Prefix', () {
    expect(format(12345.6789, prefix: " - ", postfix: "km"), " - 12,345.7km");
  });

  test('Ohne Einheit', () {
    expect(format(12345.6789), "12,345.7");
  });

  test('Null Value', () {
    expect(format(null), "");
  });

  test('Null Value with pre and postfix', () {
    expect(format(null, prefix: " - ", postfix: "km"), "");
  });

}