import 'package:fare_air/presentation/di/content_providers/content_providers.dart';
import 'package:fare_air/presentation/di/content_providers/home_content_controller.dart';
import 'package:fare_air/presentation/widgets/search_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/content/home_screen_content.dart';
import '../../models/nearby_airports_response.dart';
import '../di/providers/core_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeContentStateController? content =
        ref.watch(homeScreenContentProvider);

    switch (content?.state) {
      case AsyncLoading _:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AsyncData<HomeScreenContent?> data:
        return data.hasValue
            ? _buildHomeScreen(data.value)
            : const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AsyncError _:
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('An error occurred while loading the content'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ref.read(homeScreenContentProvider)?.initialize();
                      },
                      child: const Text('OK'),
                    )
                  ],
                ));
        return const Scaffold(body: CircularProgressIndicator());
      default:
        return const Scaffold(body: CircularProgressIndicator());
    }
  }

  Widget _buildHomeScreen(HomeScreenContent? content) {
    final FocusNode originFocusNode = FocusNode();
    final FocusNode destinationFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 75,
        leading: content?.userImage != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(content?.userImage ?? ''),
              )
            : null,
        title: Text(content?.header ?? 'header error'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TripSearchInputWidget(
              initialSearchLocation: content?.initialSearchLocation,
              originFocusNode: originFocusNode,
              destinationFocusNode: destinationFocusNode,
              onSearchOriginTap: () {
                setState(() {
                  ref
                      .read(homeScreenContentProvider)
                      ?.buildBottomSheetSearchResults(
                        context,
                        originFocusNode,
                      );

                  ref.read(homeScreenContentProvider)?.setBottomSheet(
                        buildBottomSheet(context, originFocusNode),
                      );
                });
              },
              onSearchDestinationTap: () {
                setState(() {
                  ref
                      .read(homeScreenContentProvider)
                      ?.buildBottomSheetSearchResults(
                        context,
                        destinationFocusNode,
                      );

                  ref.read(homeScreenContentProvider)?.setBottomSheet(
                        buildBottomSheet(context, destinationFocusNode),
                      );
                });
              }),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Flights Available',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Add list of available flights here
              ],
            ),
          ),
        ],
      ),
      bottomSheet: content?.bottomSheet,
    );
  }

  Widget buildBottomSheet(
    BuildContext context,
    FocusNode currentFocus,
  ) {
    final bottomSheetTextController = TextEditingController();
    return SizedBox(
        height: ref
                .watch(homeScreenContentProvider)
                ?.state
                .value
                ?.bottomSheetHeight
                .dy ??
            500,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          child: Column(
            children: [
              TextField(
                // TODO: Set on tap outside to close the bottom sheet
                onTapOutside: (_) {
                  setState(() {
                    if (currentFocus.hasFocus) {
                      currentFocus.unfocus();
                    }

                    ref.read(homeScreenContentProvider)?.setBottomSheet(null);
                  });
                },
                controller: bottomSheetTextController,
                focusNode: currentFocus,
                decoration: const InputDecoration(
                  hintText: 'Search for airports',
                ),
                onChanged: (value) {
                  // TODO: Search for airports by query.
                },
              ),
              const Divider(),
              _buildBottomSheetSearchResults(context, currentFocus),
            ],
          ),
        ));
  }

  Widget _buildBottomSheetSearchResults(
    BuildContext context,
    FocusNode currentFocus,
  ) {
    final content = ref.watch(airportServiceControllerProvider);
    final scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: false,
    );

    switch (content?.state) {
      case AsyncLoading _:
        const CircularProgressIndicator();
      case AsyncData<NearbyAirportResponse?> data:
        if (data.hasValue) {
          final returnWidget = SingleChildScrollView(
              controller: scrollController,
              child: data.hasValue
                  ? buildFlightSearchResults(context, data)
                  : const CircularProgressIndicator());
          return returnWidget;
        }
      case AsyncError _:
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('An error occurred while loading the content'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await ref.read(homeScreenContentProvider)?.initialize();
                      },
                      child: const Text('OK'),
                    )
                  ],
                ));
        return const CircularProgressIndicator();
      default:
        return const CircularProgressIndicator();
    }

    return const CircularProgressIndicator();
  }

  Widget buildFlightSearchResults(
      BuildContext context, AsyncValue<NearbyAirportResponse?> data) {
    return Column(
        children: List.generate(
      data.value?.data?.nearby?.length ?? 0,
      (index) {
        return ListTile(
          title: Text(data.value?.data?.nearby?[index].navigation
                  ?.relevantFlightParams?.localizedName ??
              ''),
          subtitle: Text(data.value?.data?.nearby?[index].navigation
                  ?.relevantFlightParams?.skyId ??
              ''),
          onTap: () {
            // TODO: Set the selected airport as the location for the flight search
          },
        );
      },
    ));
  }
}
