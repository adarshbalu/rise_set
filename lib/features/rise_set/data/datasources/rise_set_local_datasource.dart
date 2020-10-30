import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';

abstract class RiseSetLocalDataSource {
  Future<RiseSetModel> getLastRiseSetTimes();
  Future<void> cacheRiseSetTimes(RiseSetModel riseSetModelToCache);
}
