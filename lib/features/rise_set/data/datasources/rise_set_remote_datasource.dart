import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

abstract class RiseSetRemoteDataSource {
  Future<RiseSet> getRiseAndSetTime(double latitude, double longitude);
}
