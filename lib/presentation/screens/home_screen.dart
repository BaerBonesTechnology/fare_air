import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/content_providers/content_providers.dart';
import '../../models/content/home_screen_content.dart';
import '../../models/itinerary.dart';
import '../controllers/home_state_controller.dart';
import '../widgets/itinerary_widget.dart';
import '../widgets/search_input_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeStateController controller = HomeStateController();
    final homeScreenContent = ref.watch(homeScreenNotifierProvider);

    switch (homeScreenContent) {
      case AsyncData<HomeScreenContent?> data:
        return data.hasValue
            ? _buildHomeScreen(ref, context, controller)
            : const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AsyncError _:
        WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (modalContext) => AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('An error occurred while loading the content'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(modalContext);
                      },
                      child: const Text('OK'),
                    )
                  ],
                )));
        return _buildHomeScreen(ref, context, controller);
      default:
        return _buildHomeScreen(ref, context, controller);
    }
  }

  Widget _buildHomeScreen(
      WidgetRef ref, BuildContext context, HomeStateController controller) {
    final homeScreenContent = ref.watch(homeScreenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: MediaQuery.of(context).size.height * 0.075,
        title: Image.asset(width: 200, homeScreenContent.value?.header ?? ''),
      ),
      body: SafeArea(
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            TripSearchInputWidget(controller: controller),
            _buildSearchResults(ref, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(WidgetRef ref, HomeStateController controller) {
    final homeScreenContent = ref.watch(homeScreenNotifierProvider);

    switch (homeScreenContent) {
      case AsyncLoading _:
        return const Center(child: CircularProgressIndicator());
      case AsyncData<HomeScreenContent?> data:
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: data.value?.searchResults.isNotEmpty == true
                ? MediaQuery.of(context).size.height *
                    0.58 // <-- can only safely use ~98% of the screen before errors are thrown
                : null,
            child: data.hasError
                ? const Center(child: Text('Error loading search results'))
                : data.value?.searchResults.isNotEmpty == true
                    ? ListView.builder(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        itemCount: data.value?.searchResults.length ?? 0,
                        itemBuilder: (context, index) {
                          return ItineraryWidget(
                              itinerary: data.value?.searchResults[index] ??
                                  Itinerary());
                        })
                    : const Center(
                        child: Text(
                            'No search results.\nPlease search for flights')));
      case AsyncError _:
        return const Center(child: Text('Error loading search results'));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
