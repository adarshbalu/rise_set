import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/core/util/constants.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  void main() {
    RiseSetLocalDataSourceImpl dataSource;
    MockSharedPreferences mockSharedPreference;

    setUp(() {
      mockSharedPreference = MockSharedPreferences();
      dataSource =
          RiseSetLocalDataSourceImpl(sharedPreferences: mockSharedPreference);
    });

    group('getLastRiseSetTimes', () {
      final tRiseSetModel =
          RiseSetModel(sunset: DateTime(2010), sunrise: DateTime(2012));

      test('should return a riseSet from SP when there is in cache', () async {
        when(mockSharedPreference.getString(any))
            .thenReturn(fixture('rise_set_cached.json'));
        final result = await dataSource.getLastRiseSetTimes();
        verify(mockSharedPreference.getString(CACHED_RISE_SET));
        expect(result, equals(tRiseSetModel));
      });

      test('should throw a cacheException when there is no data in cache', () {
        when(mockSharedPreference.getString(any)).thenReturn(null);
        final call = dataSource.getLastRiseSetTimes;
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      });
    });

    group('cacheRiseSet data', () {
      final tRiseSetModel =
          RiseSetModel(sunset: DateTime(2010), sunrise: DateTime(2012));

      test('should call SP to cache data', () {
        dataSource.cacheRiseSetTimes(tRiseSetModel);
        final expectedJsonString = jsonEncode(tRiseSetModel.toJson());
        verify(mockSharedPreference.setString(
            CACHED_RISE_SET, expectedJsonString));
      });
    });
  }
}
