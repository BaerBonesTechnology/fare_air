import '../itinerary.dart';

class HomeScreenContent {
  HomeScreenContent({
    this.header = 'assets/fare_air_logo_alt.png',
    this.initialSearchLocation,
    this.initialEntityId,
    required this.departureDate,
    this.returnDate,
    this.departureSearchLocation,
    this.departureEntityId,
    this.adultsCount = 1,
    this.childrenCount = 0,
    this.searchResults = const [],
  });

  final String? header;
  final String? initialSearchLocation;
  final String? initialEntityId;
  final DateTime departureDate;
  final DateTime? returnDate;
  final String? departureSearchLocation;
  final String? departureEntityId;
  final int adultsCount;
  final int childrenCount;
  final List<Itinerary?> searchResults;

  HomeScreenContent copyWith({
    String? initialSearchLocation,
    String? initialEntityId,
    List<Itinerary?>? searchResults,
    DateTime? departureDate,
    DateTime? returnDate,
    String? departureSearchLocation,
    String? departureEntityId,
    int? adultsCount,
    int? childrenCount,
  }) {
    return HomeScreenContent(
      initialSearchLocation:
          initialSearchLocation ?? this.initialSearchLocation,
      initialEntityId: initialEntityId ?? this.initialEntityId,
      departureDate: departureDate ?? this.departureDate,
      returnDate: returnDate?.isAfter(departureDate ?? DateTime.now()) != true
          ? null
          : returnDate ?? this.returnDate,
      departureSearchLocation:
          departureSearchLocation ?? this.departureSearchLocation,
      departureEntityId: departureEntityId ?? this.departureEntityId,
      searchResults: searchResults ?? this.searchResults,
      adultsCount: adultsCount ?? this.adultsCount,
      childrenCount: childrenCount ?? this.childrenCount,
    );
  }

  @override
  String toString() {
    return {
      'initialSearchLocation': initialSearchLocation,
      'departureDate': departureDate,
      'returnDate': returnDate,
      'departureSearchLocation': departureSearchLocation,
      'searchResults': searchResults,
      'adultsCount': adultsCount,
      'childrenCount': childrenCount,
    }.toString();
  }

  static empty() => HomeScreenContent(
        departureDate: DateTime.now().copyWith(
          day: DateTime.now().day + 12,
        ),
      );
}
