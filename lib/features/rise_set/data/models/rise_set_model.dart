import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';

class RiseSetModel extends RiseSet {
  RiseSetModel({DateTime sunrise, DateTime sunset})
      : super(sunrise: sunrise, sunset: sunset);

  factory RiseSetModel.fromJson() {
    return RiseSetModel();
  }
}
