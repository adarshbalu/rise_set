import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/usecases/usecase.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_and_set_time.dart';

class MockRiseSetRepository extends Mock implements RiseSetRepository {}

void main() {
  GetRiseAndSetTime usecase;
  MockRiseSetRepository mockRiseSetRepository;

  setUp(() {
    mockRiseSetRepository = MockRiseSetRepository();
    usecase = GetRiseAndSetTime(mockRiseSetRepository);
  });

  final riseSet = RiseSet(sunrise: DateTime(2020), sunset: DateTime(2021));

  test('should get RiseSet from repository', () async {
    when(mockRiseSetRepository.getRiseAndSetTime())
        .thenAnswer((_) async => Right(riseSet));
    final result = await usecase.call(NoParams());
    expect(result, Right(riseSet));
    verify(mockRiseSetRepository.getRiseAndSetTime());
    verifyNoMoreInteractions(mockRiseSetRepository);
  });
}
