import 'package:fare_air/models/content/home_screen_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cms/controllers/home_screen_controller.dart';

class HomeContentStateController
    extends StateController<AsyncValue<HomeScreenContent?>> {
  HomeContentStateController(this._controller) : super(const AsyncLoading());

  final HomeScreenController? _controller;

  Future<void> initialize() async {
    try {
      await _controller?.initialize();
      state = AsyncData(_controller?.content);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  void updateContent(HomeScreenContent content) {
    state = AsyncData(content);
  }

  void buildBottomSheetSearchResults(
    BuildContext context,
    FocusNode currentSearchFocus,
  ) {
    final content = state.value?.copyWith(
      bottomSheetHeight: 500.0,
    );
    if (currentSearchFocus.canRequestFocus) {
      currentSearchFocus.requestFocus();
    }
    if (content != null) {
      updateContent(content);
    }
  }

  void searchForAirport(String query) async {
    final content = state.value?.copyWith(
      searchResults: const [],
    );
    if (content != null) {
      await _controller?.searchAirports(query).then((value) {
        if (value is AsyncData) {
          content.searchResults.addAll(value?.value?.data ?? []);
        }
      });
      updateContent(content);
    }
  }

  void setBottomSheet(Widget? bottomSheet) {
    final content = state.value?.copyWith(
      bottomSheet: bottomSheet,
    );
    if (content != null) {
      updateContent(content);
    }
  }
}
