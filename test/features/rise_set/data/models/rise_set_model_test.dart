import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSunrise = DateTime(2020);
  final tSunset = DateTime(2021);
  final tRiseSetModel = RiseSetModel(sunset: tSunset, sunrise: tSunrise);

  test('should be a subclass of RiseSet entity', () async {
    expect(tRiseSetModel, isA<RiseSet>());
  });

  group('from Json', () async {
    test('should return a valid model when json is dateTime', () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('rise_set.json'));
      final result = RiseSetModel.fromJson(jsonMap);
      expect(result, tRiseSetModel);
    });
  });
  group('to Json', () async {
    test('should return a json map containing proper data', () async {
      final result = tRiseSetModel.toJson();
      final expectedJsonMap = {
        'results': {
          'sunrise': DateTime(2010).toString(),
          'sunset': DateTime(2012).toString()
        }
      };
      expect(result, expectedJsonMap);
    });
  });
}
