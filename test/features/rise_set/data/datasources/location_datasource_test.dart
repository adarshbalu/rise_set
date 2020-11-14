import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/features/rise_set/data/datasources/location_datasource.dart';
import 'package:rise_set/features/rise_set/data/models/location_model.dart';

import '../../../../fixtures/fixture_reader.dart';

//class MockLocationDataSource extends Mock implements LocationDataSource {}

class MockLocationInfo extends Mock implements Location {}

void main() {
  LocationDataSourceImpl dataSource;
  MockLocationInfo mockLocationInfo;

  setUp(() {
    mockLocationInfo = MockLocationInfo();
    dataSource = LocationDataSourceImpl(location: mockLocationInfo);
  });

  group('get location data', () {
    final tLocation = LocationModel(latitude: 10.0, longitude: 20.0);
    test(
        'should return a locationModel from location package if there is permission',
        () async {
      final fixtureResult = fixture('location_data.json');
      final Map<String, dynamic> tdataMap = jsonDecode(fixtureResult);
      final Map<String, double> fixedMap = {
        'latitude': tdataMap['latitude'],
        'longitude': tdataMap['longitude']
      };
      final LocationData locationData = LocationData.fromMap(fixedMap);
      when(mockLocationInfo.getLocation())
          .thenAnswer((_) async => locationData);
      final result = await dataSource.getCurrentUserLocation();
      expect(result, equals(tLocation));
    });
    test('should throw location exception if location not available', () async {
      when(mockLocationInfo.getLocation()).thenReturn(null);
      final call = dataSource.getCurrentUserLocation;
      expect(() => call(), throwsA(TypeMatcher<LocationException>()));
    });
  });
}
