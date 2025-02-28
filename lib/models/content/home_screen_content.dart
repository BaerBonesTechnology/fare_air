import '../itinerary.dart';

class HomeScreenContent {
  HomeScreenContent({
    this.header = "Welcome to Fare Air",
    this.initialSearchLocation,
    this.initialEntityId,
    this.departureDate,
    this.returnDate,
    this.departureSearchLocation,
    this.departureEntityId,
    this.searchResults = const [],
  });

  final String? header;
  final String? initialSearchLocation;
  final String? initialEntityId;
  final List<Itinerary?> searchResults;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final String? departureSearchLocation;
  final String? departureEntityId;

  HomeScreenContent copyWith({
    String? header,
    String? initialSearchLocation,
    String? initialEntityId,
    List<Itinerary?>? searchResults,
    DateTime? departureDate,
    DateTime? returnDate,
    String? departureSearchLocation,
    String? departureEntityId,
  }) {
    return HomeScreenContent(
      header: header ?? this.header,
      initialSearchLocation:
          initialSearchLocation ?? this.initialSearchLocation,
      initialEntityId: initialEntityId ?? this.initialEntityId,
      departureDate: departureDate ?? this.departureDate,
      returnDate: returnDate ?? this.returnDate,
      departureSearchLocation:
          departureSearchLocation ?? this.departureSearchLocation,
      departureEntityId: departureEntityId ?? this.departureEntityId,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return {
      'header': header,
      'initialSearchLocation': initialSearchLocation,
      'departureDate': departureDate,
      'returnDate': returnDate,
      'departureSearchLocation': departureSearchLocation,
      'searchResults': searchResults,
    }.toString();
  }

  static empty() {
    return HomeScreenContent(
      header: "Welcome to Fare Air",
      initialSearchLocation: "",
      searchResults: [],
    );
  }
}
