import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class RiseSetRepositoryImpl implements RiseSetRepository {
  @override
  Future<Either<Failure, RiseSet>> getRiseAndSetTime(
      double latitude, double longitude) {
    // TODO: implement getRiseAndSetTime
    throw UnimplementedError();
  }
}
