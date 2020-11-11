import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/network/network_info.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:rise_set/features/rise_set/data/repositories/rise_set_repository_impl.dart';

class MockRemoteDataSource extends Mock implements RiseSetRemoteDataSource {}

class MockLocalDataSource extends Mock implements RiseSetLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RiseSetRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RiseSetRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getRiseSetTime', () {
    final tlat = 1.0, tLong = 1.0;
    final tRiseSetModel =
        RiseSetModel(sunrise: DateTime(2020), sunset: DateTime(2021));
    // final RiseSet riseSet = tRiseSetModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getRiseAndSetTime(tlat, tLong);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRiseAndSetTime(any, any))
              .thenAnswer((_) async => tRiseSetModel);
          // act
          final result = await repository.getRiseAndSetTime(tlat, tLong);
          // assert
          verify(mockRemoteDataSource.getRiseAndSetTime(tlat, tLong));
          expect(result, equals(Right(tRiseSetModel)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRiseAndSetTime(any, any))
              .thenAnswer((_) async => tRiseSetModel);
          // act
          await repository.getRiseAndSetTime(tlat, tLong);
          // assert
          verify(mockRemoteDataSource.getRiseAndSetTime(tlat, tLong));
          verify(mockLocalDataSource.cacheRiseSetTimes(tRiseSetModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRiseAndSetTime(any, any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getRiseAndSetTime(tlat, tLong);
          // assert
          verify(mockRemoteDataSource.getRiseAndSetTime(tlat, tLong));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastRiseSetTimes())
              .thenAnswer((_) async => tRiseSetModel);
          // act
          final result = await repository.getRiseAndSetTime(tlat, tLong);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastRiseSetTimes());
          expect(result, equals(Right(tRiseSetModel)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastRiseSetTimes())
              .thenThrow(CacheException());
          // act
          final result = await repository.getRiseAndSetTime(tlat, tLong);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastRiseSetTimes());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
