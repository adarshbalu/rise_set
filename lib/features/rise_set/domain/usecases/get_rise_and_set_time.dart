import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class GetRiseAndSetTime {
  final RiseSetRepository riseSetRepository;
  GetRiseAndSetTime(this.riseSetRepository);

  Future<Either<Failure, RiseSet>> execute() async {
    return await riseSetRepository.getRiseAndSetTime();
  }
}
