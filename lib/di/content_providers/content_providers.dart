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
      await ref
          .read(airportServiceControllerProvider)
          ?.searchForFlights(query)
          .then((value) {
        if (value is AsyncData) {
          // Parse into FlightSearchResponse
          final response = value.value;
          content = content?.copyWith(
              searchResults: (response?.data?.itineraries ?? []).isEmpty
                  ? content?.searchResults ?? []
                  : response?.data?.itineraries ?? []);
        }
      });
      await updateHomeScreenContent(content ?? HomeScreenContent.empty());
    }
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
      await ref
          .read(airportServiceControllerProvider)
          ?.searchForAirport(query)
          .then((value) {
        if (value is AsyncData) {
          // Parse into AirportQueryResponse
          final response = value.value;
          content = content?.copyWith(
              data: (response?.data ?? []).isEmpty
                  ? content?.data
                  : (response?.data ?? []));
        }
      });
      state = AsyncData(content ?? AirportQueryResponse.empty());
    }
  }

  startLoading() {
    state = const AsyncLoading();
  }
}
