import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/usecases/usecase.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_set_time_from_my_location.dart';

class MockRiseSetRepository extends Mock implements RiseSetRepository {}

void main() {
  GetRiseSetTimeFromMyLocation usecase;
  MockRiseSetRepository mockRiseSetRepository;

  setUp(() {
    mockRiseSetRepository = MockRiseSetRepository();
    usecase = GetRiseSetTimeFromMyLocation(mockRiseSetRepository);
  });

  final riseSet = RiseSet(sunrise: DateTime(2020), sunset: DateTime(2021));

  test('should get RiseSet from repository for my location', () async {
    when(mockRiseSetRepository.getRiseAndSetTimeFromMyLocation())
        .thenAnswer((_) async => Right(riseSet));
    final result = await usecase.call(NoParams());
    expect(result, Right(riseSet));
    verify(mockRiseSetRepository.getRiseAndSetTimeFromMyLocation());
    verifyNoMoreInteractions(mockRiseSetRepository);
  });
}
