import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

abstract class RiseSetRepository {
  Future<Either<Failure, RiseSet>> getRiseAndSetTime(
      double latitude, double longitude);
}
