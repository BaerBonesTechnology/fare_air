import 'package:fare_air/presentation/controllers/home_state_controller.dart';
import 'package:fare_air/presentation/widgets/itinerary_widget.dart';
import 'package:fare_air/presentation/widgets/search_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/content/home_screen_content.dart';
import '../../models/itinerary.dart';
import '../di/content_providers/content_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeStateController controller = HomeStateController();

    switch (ref.watch(homeScreenNotifierProvider)) {
      case AsyncLoading _:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AsyncData<HomeScreenContent?> data:
        return data.hasValue
            ? _buildHomeScreen(ref, context, controller)
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
                      onPressed: () {},
                      child: const Text('OK'),
                    )
                  ],
                ));
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      default:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _buildHomeScreen(
      WidgetRef ref, BuildContext context, HomeStateController controller) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 75,
        title: Image.asset(
            width: 200,
            ref.watch(homeScreenNotifierProvider).value?.header ??
                'header error'),
      ),
      body: _buildSearchResults(ref, controller),
    );
  }

  Widget _buildSearchResults(WidgetRef ref, HomeStateController controller) {
    switch (ref.watch(homeScreenNotifierProvider)) {
      case AsyncLoading _:
        return const Center(child: CircularProgressIndicator());
      case AsyncData<HomeScreenContent?> data:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripSearchInputWidget(controller: controller),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.6299,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: ref.watch(homeScreenNotifierProvider).hasError
                      ? const [
                          Center(child: Text('Error loading search results'))
                        ]
                      : ref
                                  .watch(homeScreenNotifierProvider)
                                  .value
                                  ?.searchResults
                                  .isNotEmpty ==
                              true
                          ? List.generate(
                              ref
                                      .watch(homeScreenNotifierProvider)
                                      .value
                                      ?.searchResults
                                      .length ??
                                  0, (index) {
                              return ItineraryWidget(
                                  itinerary: ref
                                          .watch(homeScreenNotifierProvider)
                                          .value
                                          ?.searchResults[index] ??
                                      Itinerary());
                            })
                          : const [
                              Center(
                                  child: Text(
                                      'No search results.\nPlease search for flights'))
                            ],
                ),
              ),
            ),
          ],
        );
      case AsyncError _:
        return const Center(child: Text('Error loading search results'));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
