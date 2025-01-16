import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<bool> hasServiceEnabled() async {
    return await location.requestService();
  }

  Future<LocationData> getCurrentLocation() async {
    bool permission = await requestPermission();
    bool serviceEnabled = await hasServiceEnabled();

    return await location.getLocation();
  }
}
