import 'package:location/location.dart';

abstract class LocationDataSource {
  Future<LocationData> getCurrentUserLocation();
  Future<bool> getLocationAccessPermissions();
}
