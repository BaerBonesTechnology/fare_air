import 'package:flutter/widgets.dart';

import '../current_airport_data.dart';

class BottomSheetContent {
  BottomSheetContent({
    this.bottomSheetHeight = 0,
    this.searchResults = const [],
    this.controller,
  });

  final double bottomSheetHeight;
  final List<AirportData?> searchResults;
  final TextEditingController? controller;
  final FocusNode? focusNode = FocusNode();

  BottomSheetContent copyWith({
    double? bottomSheetHeight,
    List<AirportData?>? searchResults,
    TextEditingController? controller,
  }) {
    return BottomSheetContent(
      bottomSheetHeight: bottomSheetHeight ?? this.bottomSheetHeight,
      searchResults: searchResults ?? this.searchResults,
      controller: controller ?? this.controller,
    );
  }

  static BottomSheetContent empty() {
    return BottomSheetContent();
  }

  @override
  String toString() {
    return {
      'bottomSheetHeight': bottomSheetHeight,
      'searchResults': searchResults,
    }.toString();
  }
}
