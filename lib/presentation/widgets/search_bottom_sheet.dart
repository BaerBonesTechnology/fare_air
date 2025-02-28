import 'package:fare_air/constants/defaults.dart';
import 'package:fare_air/models/airport_search_params.dart';
import 'package:fare_air/models/content/bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/airport_query_response.dart';
import '../../models/content/home_screen_content.dart';
import '../di/content_providers/content_providers.dart';

class SearchBottomSheet extends ConsumerStatefulWidget {
  const SearchBottomSheet({
    super.key,
    this.tag,
  });

  final String? tag;

  @override
  ConsumerState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends ConsumerState<SearchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onTapOutside: (pointer) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          focusNode: ref.watch(bottomSheetNotifierProvider).value?.focusNode,
          decoration: const InputDecoration(
            hintText: 'Search for an airport',
          ),
          onChanged: (value) async {
            // Do something with the value
            bool readyToSearch = false;
            await Future.delayed(const Duration(seconds: 1), () {
              readyToSearch = true;
            });

            if (!readyToSearch) {
              return;
            }
            ref.read(airportQueryNotifierProvider.notifier).startLoading();

            final query = AirportSearchParams.buildQueryUrl(value);
            await ref
                .read(airportQueryNotifierProvider.notifier)
                .updateAirportQuery(ref, query);

            if (ref.watch(bottomSheetNotifierProvider).value != null) {
              await ref
                  .read(bottomSheetNotifierProvider.notifier)
                  .updateBottomSheetContent(ref
                          .watch(bottomSheetNotifierProvider)
                          .value
                          ?.copyWith(
                              searchResults: ref
                                  .watch(airportQueryNotifierProvider)
                                  .value
                                  ?.data) ??
                      ref.watch(bottomSheetNotifierProvider).value!);
            }
          },
        ),
        const Divider(),
        SizedBox(height: 394.0, child: buildSearchResults(context)),
      ],
    );
  }

  Widget buildSearchResults(BuildContext context) {
    switch (ref.watch(airportQueryNotifierProvider)) {
      case AsyncLoading _:
        return const Center(child: CircularProgressIndicator());
      case AsyncError _:
        return const Center(child: Text('Error loading search results'));
      case AsyncData<AirportQueryResponse> results:
        return SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: results.value.data.length ?? 0,
              itemBuilder: (context, index) {
                final airport =
                    results.value.data[index].navigation?.relevantFlightParams;
                return ListTile(
                  title: Text(airport?.localizedName ?? ''),
                  subtitle: Text(airport?.skyId ?? ''),
                  onTap: () async {
                    ref
                        .read(homeScreenNotifierProvider.notifier)
                        .updateHomeScreenContent(widget.tag == originTag
                            ? ref
                                    .read(homeScreenNotifierProvider)
                                    .value
                                    ?.copyWith(
                                      initialSearchLocation:
                                          airport?.skyId ?? '',
                                      initialEntityId: airport?.entityId ?? '',
                                    ) ??
                                HomeScreenContent.empty()
                            : ref
                                    .read(homeScreenNotifierProvider)
                                    .value
                                    ?.copyWith(
                                      departureSearchLocation:
                                          airport?.skyId ?? '',
                                      departureEntityId:
                                          airport?.entityId ?? '',
                                    ) ??
                                HomeScreenContent.empty());

                    ref
                        .read(bottomSheetNotifierProvider.notifier)
                        .updateBottomSheetContent(
                          ref
                                  .watch(bottomSheetNotifierProvider)
                                  .value
                                  ?.copyWith(
                                      searchResults: [],
                                      bottomSheetHeight: 0.0,
                                      controller: null) ??
                              BottomSheetContent.empty(),
                        );

                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
