import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/location_info/location_info.dart';
import 'package:rise_set/core/network/network_info.dart';
import 'package:rise_set/features/rise_set/data/datasources/location_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
import 'package:rise_set/features/rise_set/data/models/location_model.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class RiseSetRepositoryImpl implements RiseSetRepository {
  final RiseSetRemoteDataSource remoteDataSource;
  final RiseSetLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final LocationInfo locationInfo;
  final LocationDataSource locationDataSource;

  RiseSetRepositoryImpl(
      {@required this.locationDataSource,
      @required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo,
      @required this.locationInfo});

  @override
  Future<Either<Failure, RiseSet>> getRiseAndSetTimeFromCustomLocation(
      double latitude, double longitude) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRiseSet =
            await remoteDataSource.getRiseAndSetTime(latitude, longitude);
        await localDataSource.cacheRiseSetTimes(remoteRiseSet);
        return Right(remoteRiseSet);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRiseSet = await localDataSource.getLastRiseSetTimes();
        return Right(localRiseSet);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, RiseSet>> getRiseAndSetTimeFromMyLocation() async {
    if (await locationInfo.isLocationServiceAvailable) {
      try {
        final LocationModel locationModel =
            await locationDataSource.getCurrentUserLocation();
        return await getRiseAndSetTimeFromCustomLocation(
            locationModel.latitude, locationModel.longitude);
      } on LocationException {
        return Left(LocationFailure());
      }
    } else {
      return Left(LocationFailure());
    }
  }
}
