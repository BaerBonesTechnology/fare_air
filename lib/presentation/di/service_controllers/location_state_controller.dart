import 'package:fare_air/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationStateController extends StateController<LocationData?> {
  LocationStateController(this.service) : super(null);
  final LocationService? service;

  Future<void> checkPermissions() async =>
      state = await service?.checkPermissions();

  String? loadLastSearchedHomeLocation() =>
      service?.loadLastSearchedHomeLocation();

  void saveLastSearchedHomeLocation(String location) async =>
      service?.saveLastSearchedHomeLocation(location);
}
