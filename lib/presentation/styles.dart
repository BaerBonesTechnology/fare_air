import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primarySwatch: Colors.lightGreen,
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        gapPadding: 1,
        borderSide: BorderSide.none,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: const WidgetStatePropertyAll(Colors.yellow),
      foregroundColor: const WidgetStatePropertyAll(Colors.black),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  ),
);
