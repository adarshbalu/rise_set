import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/usecases/usecase.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class GetRiseAndSetTime implements UseCase<RiseSet, NoParams> {
  final RiseSetRepository riseSetRepository;
  GetRiseAndSetTime(this.riseSetRepository);

  Future<Either<Failure, RiseSet>> call(NoParams noParams) async {
    return await riseSetRepository.getRiseAndSetTime();
  }
}
