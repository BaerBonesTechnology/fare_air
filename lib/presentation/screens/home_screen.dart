import 'package:fare_air/presentation/widgets/search_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/content/home_screen_content.dart';
import '../di/content_providers/content_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    switch (ref.watch(homeScreenNotifierProvider)) {
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

  Widget _buildHomeScreen(HomeScreenContent? content) {
    final FocusNode originFocusNode = FocusNode();
    final FocusNode destinationFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 75,
        title: Text(ref.watch(homeScreenNotifierProvider).value?.header ??
            'header error'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TripSearchInputWidget(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: const SingleChildScrollView(
                  child: Placeholder(
                child: Text('Flight Search Results'),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
