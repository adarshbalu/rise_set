import 'package:location/location.dart';

abstract class LocationInfo {
  Future<bool> get isLocationServiceAvailable;
  // Future<Permission> get isLocationPermssionAvailable;
}

class LocationInfoImpl implements LocationInfo {
  final Location location;

  LocationInfoImpl(this.location);

  // @override
  // Future<Permission> get isLocationPermssionAvailable async {
  //   final permissionStatus = await location.hasPermission();
  //   if (permissionStatus == PermissionStatus.granted) {
  //     return Permission.Granted;
  //   } else
  //     return Permission.Denied;
  // }

  @override
  Future<bool> get isLocationServiceAvailable => location.serviceEnabled();
}

enum Permission { Granted, Denied }
