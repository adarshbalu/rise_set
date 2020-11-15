import 'package:location/location.dart';
import 'package:rise_set/features/rise_set/domain/entities/locations.dart';

class LocationModel extends Locations {
  LocationModel({double latitude, double longitude})
      : super(latitude: latitude, longitude: longitude);

  factory LocationModel.fromLocationData(LocationData locationData) {
    return LocationModel(
        latitude: locationData.latitude, longitude: locationData.longitude);
  }
}
