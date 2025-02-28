import 'package:json_annotation/json_annotation.dart';

import 'itinerary.dart';

part 'flight_search_data.g.dart';

@JsonSerializable()
class FlightSearchData {
  FlightSearchData({
    required this.itineraries,
  });

  List<Itinerary> itineraries;

  factory FlightSearchData.fromJson(Map<String, dynamic> json) =>
      _$FlightSearchDataFromJson(json);
}
