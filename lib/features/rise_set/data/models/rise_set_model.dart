import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

class RiseSetModel extends RiseSet {
  RiseSetModel({DateTime sunrise, DateTime sunset})
      : super(sunrise: sunrise, sunset: sunset);

  factory RiseSetModel.fromJson(Map<String, dynamic> json) {
    return RiseSetModel(
        sunrise: DateTime.parse(json['results']['sunrise']),
        sunset: DateTime.parse(json['results']['sunset']));
  }

  Map<String, dynamic> toJson() {
    return {
      'results': {
        'sunrise': sunrise.toIso8601String(),
        'sunset': sunset.toIso8601String()
      }
    };
  }
}
