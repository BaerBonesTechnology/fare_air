import 'package:fare_air/models/content/home_screen_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeContentStateController
    extends StateController<AsyncValue<HomeScreenContent?>> {
  HomeContentStateController() : super(const AsyncLoading());

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

  void setBottomSheet(Widget? bottomSheet) {
    final content = state.value?.copyWith(
      bottomSheet: bottomSheet,
    );
    if (content != null) {
      updateContent(content);
    }
  }
}
