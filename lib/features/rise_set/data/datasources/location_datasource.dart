import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:rise_set/features/rise_set/data/models/location_model.dart';

abstract class LocationDataSource {
  Future<LocationModel> getCurrentUserLocation();
}

class LocationDataSourceImpl extends LocationDataSource {
  final Location location;

  LocationDataSourceImpl({@required this.location});
  @override
  Future<LocationModel> getCurrentUserLocation() async {
    final locationData = await location.getLocation();
    return LocationModel.fromLocationData(locationData);
  }
}
