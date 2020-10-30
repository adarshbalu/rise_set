import 'package:flutter_test/flutter_test.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

void main() {
  final tSunrise = DateTime(2020);
  final tSunset = DateTime(2021);
  final tRiseSetModel = RiseSetModel(sunset: tSunset, sunrise: tSunrise);

  test('should be a subclass of RiseSet entity', () async {
    expect(tRiseSetModel, isA<RiseSet>());
  });
}
