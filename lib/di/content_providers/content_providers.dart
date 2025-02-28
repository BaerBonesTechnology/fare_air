import 'package:fare_air/models/flight_search_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/airport_query_response.dart';
import '../../../models/content/bottom_sheet_content.dart';
import '../../../models/content/home_screen_content.dart';
import '../providers/core_providers.dart';

part 'content_providers.g.dart';

@riverpod
class BottomSheetNotifier extends _$BottomSheetNotifier {
  @override
  Future<BottomSheetContent> build() async {
    return BottomSheetContent(
      bottomSheetHeight: 0,
      searchResults: [],
    );
  }

  Future<void> updateBottomSheetContent(BottomSheetContent content) async {
    state = AsyncData(content);
  }

  Future<void> startLoading() async {
    state = const AsyncLoading();
  }
}

@riverpod
class HomeScreenNotifier extends _$HomeScreenNotifier {
  @override
  Future<HomeScreenContent> build() => state.maybeWhen(
      data: (content) => Future.value(content),
      orElse: () => Future.value(
            HomeScreenContent.empty(),
          ));

  Future<void> updateHomeScreenContent(HomeScreenContent content) async {
    state = AsyncData(content);
  }

  Future getFlights(WidgetRef ref, FlightSearchParameters query) async {
    var content = state.value;

    state = const AsyncLoading();

    if (content != null) {
      final flightData = await ref
          .read(airportServiceControllerProvider)
          ?.searchForFlights(query);

      switch (flightData) {
        case AsyncLoading _:
          break;
        case AsyncData data:
          // Parse into FlightSearchResponse
          final response = data.value;
          content = content.copyWith(
              searchResults: (response?.data?.itineraries ?? []).isEmpty
                  ? content.searchResults ?? []
                  : response?.data?.itineraries ?? []);
        case AsyncError error:
          state = AsyncError(error.error, error.stackTrace);
          return;
      }
    }
    await updateHomeScreenContent(content ?? HomeScreenContent.empty());
  }
}

@riverpod
class AirportQueryNotifier extends _$AirportQueryNotifier {
  @override
  Future<AirportQueryResponse> build() async {
    return AirportQueryResponse(
      data: [],
      status: false,
      timestamp: 0,
    );
  }

  Future<void> updateAirportQuery(WidgetRef ref, String query) async {
    state = const AsyncLoading();

    var content = state.value?.copyWith(
      data: const [],
    );

    if (content != null) {
      final airportData = await ref
          .read(airportServiceControllerProvider)
          ?.searchForAirport(query);

      switch (airportData) {
        case AsyncLoading _:
          break;
        case AsyncData value:
          final response = value.value;
          content = content.copyWith(
              data: (response?.data ?? []).isEmpty
                  ? content.data
                  : (response?.data ?? []));
          break;
        case AsyncError error:
          state = AsyncError(error.error, error.stackTrace);
          return;
      }
      state = AsyncData(content);
    }
  }

  startLoading() {
    state = const AsyncLoading();
  }
}
