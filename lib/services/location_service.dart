import 'package:location/location.dart';

class LocationService {
  Future<LocationData?> checkPermissions() async {
    return null;
  }

  String? loadLastSearchedHomeLocation() {
    return '';
  }

  void saveLastSearchedHomeLocation(String location) async {}
}
