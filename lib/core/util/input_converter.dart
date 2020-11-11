import 'package:dartz/dartz.dart';
import 'package:rise_set/core/error/failures.dart';

class InputConverter {
  Either<Failure, double> stringToDouble(String str) {
    try {
      final dou = double.tryParse(str);
      if (dou.isNaN) throw FormatException();
      return Right(dou);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
