import 'package:flutter/cupertino.dart';

import '../current_airport_data.dart';

class HomeScreenContent {
  HomeScreenContent({
    this.header,
    this.userImage,
    this.initialSearchLocation,
    this.centerHeader = false,
    this.bottomSheetHeight = const Offset(0, 500),
    this.bottomSheet,
    this.searchResults = const [],
  });

  final String? header;
  final String? userImage;
  final String? initialSearchLocation;
  final bool centerHeader;
  final Offset bottomSheetHeight;
  final Widget? bottomSheet;
  final List<AirportData?> searchResults;

  HomeScreenContent copyWith({
    String? header,
    String? userImage,
    String? initialSearchLocation,
    bool? centerHeader,
    double? bottomSheetHeight,
    Widget? bottomSheet,
    List<AirportData?>? searchResults,
  }) {
    return HomeScreenContent(
      header: header ?? this.header,
      userImage: userImage ?? this.userImage,
      initialSearchLocation:
          initialSearchLocation ?? this.initialSearchLocation,
      centerHeader: centerHeader ?? this.centerHeader,
      bottomSheetHeight:
          Offset(0, bottomSheetHeight ?? this.bottomSheetHeight.dy),
      bottomSheet: bottomSheet ?? this.bottomSheet,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return {
      'header': header,
      'userImage': userImage,
      'initialSearchLocation': initialSearchLocation,
      'centerHeader': centerHeader,
      'bottomSheetHeight': bottomSheetHeight,
      'bottomSheet': bottomSheet,
      'searchResults': searchResults,
    }.toString();
  }
}
