import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/network/network_info.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
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
}
