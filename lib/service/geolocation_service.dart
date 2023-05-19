import 'package:geolocator/geolocator.dart';

abstract class GeolocationServiceInterface {
  Future<bool> _enableGeolocation();
  Future<void> _requestPermissions();
  bool isPermissionEnabled();
  Future<Position> getPosition();
  Future<bool> start();
}
