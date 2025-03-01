import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/defaults.dart';
import '../../di/content_providers/content_providers.dart';
import '../../models/airport_query_response.dart';
import '../../models/airport_search_params.dart';
import '../../models/content/bottom_sheet_content.dart';
import '../../models/content/home_screen_content.dart';

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final FocusNode? node =
          ref.read(bottomSheetNotifierProvider).value?.focusNode;
      node?.canRequestFocus == true ? node?.requestFocus() : {};
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetContent = ref.watch(bottomSheetNotifierProvider);
    final FocusNode? node = bottomSheetContent.value?.focusNode;

    return Flex(
      clipBehavior: Clip.hardEdge,
      direction: Axis.vertical,
      children: [
        TextField(
            onTapOutside: (pointer) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            focusNode: node,
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

              switch (ref.watch(airportQueryNotifierProvider)) {
                case AsyncLoading _:
                  break;
                case AsyncData data:
                  await ref
                      .read(bottomSheetNotifierProvider.notifier)
                      .updateBottomSheetContent(ref
                              .watch(bottomSheetNotifierProvider)
                              .value
                              ?.copyWith(searchResults: data.value?.data) ??
                          bottomSheetContent.value!);
                  break;
                case AsyncError _:
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (modalContext) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Error loading search results'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(modalContext);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
              }
            }),
        const Divider(),
        Expanded(
          child: buildSearchResults(context),
        ),
      ],
    );
  }

  Widget buildSearchResults(BuildContext context) {
    switch (ref.watch(airportQueryNotifierProvider)) {
      case AsyncLoading _:
        return const Center(child: CircularProgressIndicator());
      case AsyncError _:
        WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
              context: context,
              builder: (modalContext) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Error loading search results'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            ));
        return const Center(child: Text('Error loading search results'));
      case AsyncData<AirportQueryResponse> results:
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(),
            itemCount: results.value.data.length,
            itemBuilder: (_, index) {
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
                                    initialSearchLocation: airport?.skyId ?? '',
                                    initialEntityId: airport?.entityId ?? '',
                                  ) ??
                              HomeScreenContent.empty()
                          : ref
                                  .read(homeScreenNotifierProvider)
                                  .value
                                  ?.copyWith(
                                    departureSearchLocation:
                                        airport?.skyId ?? '',
                                    departureEntityId: airport?.entityId ?? '',
                                  ) ??
                              HomeScreenContent.empty());

                  ref
                      .read(bottomSheetNotifierProvider.notifier)
                      .updateBottomSheetContent(
                        ref.watch(bottomSheetNotifierProvider).value?.copyWith(
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
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
