import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/core/util/constants.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RiseSetLocalDataSource {
  Future<RiseSetModel> getLastRiseSetTimes();
  Future<void> cacheRiseSetTimes(RiseSetModel riseSetModelToCache);
}

class RiseSetLocalDataSourceImpl extends RiseSetLocalDataSource {
  final SharedPreferences sharedPreferences;

  RiseSetLocalDataSourceImpl({@required this.sharedPreferences});
  @override
  Future<void> cacheRiseSetTimes(RiseSetModel riseSetModelToCache) {
    final jsonString = sharedPreferences.getString(CACHED_RISE_SET);
    if (jsonString != null) {
      return Future.value(RiseSetModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<RiseSetModel> getLastRiseSetTimes() {
    // TODO: implement getLastRiseSetTimes
    throw UnimplementedError();
  }
}
