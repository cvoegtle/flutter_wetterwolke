import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/data/locationcalculator.dart';

void main() {
  var bali = Position(51.775263, 8.810188);
  var tegelweg = Position(51.723779, 8.758523);
  var freiburg = Position(48.02387, 7.862207);
  var shenzhen = Position(22.5819833, 114.1198333);

  test('Entfernung Paderborn - Bad Lippspringe', () {
    expect(tegelweg.distanceTo(bali), 6.739637248733924);
  });

  test('Entfernung Paderborn - Freiburg', () {
    expect(tegelweg.distanceTo(freiburg), 416.3859995151228);
  });

  test('Entfernung Paderborn - Shenzhen', () {
    expect(tegelweg.distanceTo(shenzhen), 9048.649256597426);
  });

}