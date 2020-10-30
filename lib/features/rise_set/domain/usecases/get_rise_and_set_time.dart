import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/usecases/usecase.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';

class GetRiseAndSetTime implements UseCase<RiseSet, Params> {
  final RiseSetRepository riseSetRepository;
  GetRiseAndSetTime(this.riseSetRepository);

  Future<Either<Failure, RiseSet>> call(Params params) async {
    return await riseSetRepository.getRiseAndSetTime(
        params.latitude, params.longitude);
  }
}

class Params extends Equatable {
  final double latitude, longitude;

  Params({@required this.latitude, @required this.longitude});
  @override
  List<Object> get props => [latitude, longitude];
}
