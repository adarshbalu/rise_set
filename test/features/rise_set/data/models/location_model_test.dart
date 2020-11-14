import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rise_set/features/rise_set/data/models/location_model.dart';
import 'package:location/location.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tLatitude = 10.0;
  final tLongitude = 20.0;
  final tLocationModel =
      LocationModel(latitude: tLatitude, longitude: tLongitude);

  test('Should be a subclass of locations entity', () async {
    expect(tLocationModel, isA<LocationModel>());
  });

  group('from LocationData', () {
    test('should be a valid model when locationData is valid', () {
      final fixtureResult = fixture('location_data.json');
      final Map<String, dynamic> tdataMap = jsonDecode(fixtureResult);
      final Map<String, double> fixedMap = {
        'latitude': tdataMap['latitude'],
        'longitude': tdataMap['longitude']
      };
      final LocationData locationData = LocationData.fromMap(fixedMap);
      final result = LocationModel.fromLocationData(locationData);
      expect(result, tLocationModel);
    });
  });
}
