import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/usecases/usecase.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class GetRiseSetTimeFromMyLocation implements UseCase<RiseSet, NoParams> {
  final RiseSetRepository riseSetRepository;

  GetRiseSetTimeFromMyLocation(this.riseSetRepository);

  @override
  Future<Either<Failure, RiseSet>> call(NoParams params) async {
    return await riseSetRepository.getRiseAndSetTimeFromMyLocation();
  }
}
