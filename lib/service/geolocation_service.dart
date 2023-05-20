// ignore_for_file: unused_element

import 'package:geolocator/geolocator.dart';

abstract class GeolocationServiceInterface {
  Future<bool> _enableGeolocation();
  Future<void> _requestPermissions();
  bool isPermissionEnabled();
  Future<Position> getPosition();
  Future<bool> start();
}

class GeoloctionService implements GeolocationServiceInterface {
  bool _serviceEnabled = false;
  late LocationPermission _permission;

  @override
  Future<bool> _enableGeolocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    return Future.sync(() => true);
  }

  @override
  Future<void> _requestPermissions() async {
    _permission = await Geolocator.checkPermission();
    if (isPermissionEnabled()) {
      return Future.error("Permisson denied");
    }

    return Future.sync(() => null);
  }

  @override
  Future<Position> getPosition() {
    return Geolocator.getCurrentPosition();
  }

  @override
  bool isPermissionEnabled() {
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> start() async {
    bool enabled = await _enableGeolocation();

    if (enabled) {
      await _requestPermissions();
      return Future.sync(() => isPermissionEnabled());
    }

    return Future.sync(() => false);
  }
}
