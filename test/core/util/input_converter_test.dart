import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rise_set/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringTODouble', () {
    test(
      'should return an double when the string represents an double',
      () async {
        // arrange
        final str = '123.6';
        // act
        final result = inputConverter.stringToDouble(str);
        // assert
        expect(result, Right(123.6));
      },
    );

    test(
      'should return a Failure when the string is not an double',
      () async {
        // arrange
        final str = 'abc';
        // act
        final result = inputConverter.stringToDouble(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
