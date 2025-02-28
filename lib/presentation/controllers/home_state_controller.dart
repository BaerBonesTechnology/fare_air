import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/content/bottom_sheet_content.dart';
import '../../../models/content/home_screen_content.dart';
import '../../../models/flight_search_params.dart';
import '../../di/content_providers/content_providers.dart';
import '../widgets/search_bottom_sheet.dart';

class HomeStateController {
  Future openBottomSheet(
      BuildContext context, WidgetRef ref, String tag) async {
    final bottomSheetContent = ref.watch(bottomSheetNotifierProvider);
    // Open the bottom sheet
    await ref
        .read(bottomSheetNotifierProvider.notifier)
        .updateBottomSheetContent(BottomSheetContent(
          controller: bottomSheetContent.value?.controller,
        ));

    if (context.mounted) {
      showModalBottomSheet(
          context: context,
          showDragHandle: true,
          enableDrag: true,
          builder: (_) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBottomSheet(
                  tag: tag,
                ),
              ));
    }
  }

  Future searchForFlights(WidgetRef ref) async {
    debugPrint('Search button pressed');
    final content = ref.watch(homeScreenNotifierProvider);
    final FlightSearchParameters params = FlightSearchParameters(
      originSkyId: content.value?.initialSearchLocation ?? '',
      originEntityId: content.value?.initialEntityId ?? '',
      destinationSkyId: content.value?.departureSearchLocation ?? '',
      destinationEntityId: content.value?.departureEntityId ?? '',
      departureDate: content.value?.departureDate ?? DateTime.now(),
      returnDate: content.value?.returnDate,
      adultsCount: content.value?.adultsCount ?? 1,
      childrenCount: content.value?.childrenCount ?? 0,
    );

    await ref.read(homeScreenNotifierProvider.notifier).getFlights(ref, params);
  }

  Future updateAdultsCount(WidgetRef ref, int count) async {
    await ref.read(homeScreenNotifierProvider.notifier).updateHomeScreenContent(
          ref.watch(homeScreenNotifierProvider).value?.copyWith(
                    adultsCount: count,
                  ) ??
              HomeScreenContent.empty(),
        );
  }

  Future updateChildrenCount(WidgetRef ref, int count) async {
    await ref.read(homeScreenNotifierProvider.notifier).updateHomeScreenContent(
          ref.watch(homeScreenNotifierProvider).value?.copyWith(
                    childrenCount: count,
                  ) ??
              HomeScreenContent.empty(),
        );
  }
}
