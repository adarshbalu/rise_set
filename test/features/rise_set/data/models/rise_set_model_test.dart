import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSunrise = DateTime.parse('2015-05-21T05:05:35+00:00');
  final tSunset = DateTime.parse('2015-05-21T19:22:59+00:00');
  final tRiseSetModel = RiseSetModel(sunset: tSunset, sunrise: tSunrise);

  test('should be a subclass of RiseSet entity', () async {
    expect(tRiseSetModel, isA<RiseSet>());
  });

  group('from Json', () {
    test('should return a valid model when json is dateTime', () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('rise_set.json'));
      final result = RiseSetModel.fromJson(jsonMap);
      expect(result, tRiseSetModel);
    });
  });
  group('to Json', () {
    test('should return a json map containing proper data', () async {
      final result = tRiseSetModel.toJson();
      final expectedJsonMap = {
        'results': {
          'sunrise':
              DateTime.parse('2015-05-21T05:05:35+00:00').toIso8601String(),
          'sunset':
              DateTime.parse('2015-05-21T19:22:59+00:00').toIso8601String()
        }
      };
      expect(result, expectedJsonMap);
    });
  });
}
