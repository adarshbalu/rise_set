import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/network/network_info.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class RiseSetRepositoryImpl implements RiseSetRepository {
  final RiseSetRemoteDataSource remoteDataSource;
  final RiseSetLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RiseSetRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, RiseSet>> getRiseAndSetTime(
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
}
