import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rise_set/core/error/exceptions.dart';
import 'package:rise_set/features/rise_set/data/models/rise_set_model.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

abstract class RiseSetRemoteDataSource {
  Future<RiseSet> getRiseAndSetTime(double latitude, double longitude);
}

class RiseSetRemoteDataSourceImpl extends RiseSetRemoteDataSource {
  final http.Client client;

  RiseSetRemoteDataSourceImpl({@required this.client});

  @override
  Future<RiseSet> getRiseAndSetTime(double latitude, double longitude) =>
      _getRiseSetFromUrl(
          'https://api.sunrise-sunset.org/json?lat=$latitude&lng=$longitude&formatted=0');

  Future<RiseSetModel> _getRiseSetFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return RiseSetModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
