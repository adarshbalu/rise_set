import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RiseSetRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RiseSetRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('rise_set.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get Rise set times', () {
    final tLat = 1.9;
    final tLong = 1.7;
    final tRiseSetModel =
        RiseSetModel.fromJson(json.decode(fixture('rise_set.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRiseAndSetTime(tLat, tLong);
        // assert
        verify(mockHttpClient.get(
          'https://api.sunrise-sunset.org/json?lat=$tLat&lng=$tLong&formatted=0',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return RiseSet when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRiseAndSetTime(tLat, tLong);
        // assert
        expect(result, equals(tRiseSetModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRiseAndSetTime;
        // assert
        expect(
            () => call(tLat, tLong), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
