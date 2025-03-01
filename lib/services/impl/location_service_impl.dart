import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/preference_keys.dart';
import '../location_service.dart';

class LocationServiceImpl implements LocationService {
  LocationServiceImpl(
    this.prefs,
  ) : super();

  SharedPreferences? prefs;

  @override
  Future<loc.LocationData?> checkPermissions() async {
    // Handle permission requests
    final ServiceStatus locationStatus =
        await Permission.location.serviceStatus;

    if (locationStatus == ServiceStatus.disabled) {
      await Permission.location.request();
    } else {
      final PermissionStatus locationPermission =
          await Permission.location.status;

      switch (locationPermission) {
        case PermissionStatus.permanentlyDenied:
        case PermissionStatus.restricted:
          break;
        case PermissionStatus.denied:
          await Permission.location.request();
          checkPermissions();
          break;
        case PermissionStatus.granted:
          return _getLocation();
        default:
          break;
      }
    }
    return null;
  }

  @override
  String? loadLastSearchedHomeLocation() {
    // Load last searched location
    return prefs?.getString(lastSearchedLocationKey);
  }

  @override
  void saveLastSearchedHomeLocation(String location) async {
    // Save last searched location
    prefs?.setString(lastSearchedLocationKey, location);
  }

  Future<loc.LocationData?> _getLocation() async {
    final loc.Location location = loc.Location();
    return await location.getLocation();
  }
}
