import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rise_set/core/location_info/location_info.dart';
import 'package:location/location.dart';

class MockLocationAccessChecker extends Mock implements Location {}

void main() {
  LocationInfoImpl locationInfo;
  MockLocationAccessChecker mockLocationAccessChecker;

  setUp(() {
    mockLocationAccessChecker = MockLocationAccessChecker();
    locationInfo = LocationInfoImpl(mockLocationAccessChecker);
  });

  group('Has Service', () {
    test('should forward call to location.hasService', () async {
      final tHasServiceFuture = Future.value(true);

      when(mockLocationAccessChecker.serviceEnabled())
          .thenAnswer((_) => tHasServiceFuture);

      final result = locationInfo.isLocationServiceAvailable;
      verify(mockLocationAccessChecker.serviceEnabled());
      expect(result, tHasServiceFuture);
    });
  });

  //  group('Has Permission', () {
  //   test('should forward call to location.hasPermssion', () async {
  //     final tHasPermissionFuture = Future.value(Permission.Granted);

  //     when(mockLocationAccessChecker.hasPermission())
  //         .thenAnswer((_) => tHasPermissionFuture);

  //     final result = locationInfo.isLocationServiceAvailable;
  //     verify(mockLocationAccessChecker.serviceEnabled());
  //     expect(result, tHasServiceFuture);
  //   });
  // });
}
