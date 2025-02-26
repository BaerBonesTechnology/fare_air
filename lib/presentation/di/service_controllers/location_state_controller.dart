import 'package:fare_air/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationStateController extends StateController<LocationData?> {
  LocationStateController(this._locationService) : super(null);
  final LocationService? _locationService;

  void checkPermissions() async =>
      state = await _locationService?.checkPermissions();

  String? loadLastSearchedHomeLocation() =>
      _locationService?.loadLastSearchedHomeLocation();

  void saveLastSearchedHomeLocation(String location) async =>
      _locationService?.saveLastSearchedHomeLocation(location);
}
