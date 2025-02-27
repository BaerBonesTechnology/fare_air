import 'package:flutter/animation.dart';

class Animations {
  static Tween<int> bottomSheetRaiseOffsetTween(height) => Tween<int>(
        begin: 0,
        end: height,
      );

  static Tween<int> bottomSheetLowerOffsetTween(height) => Tween<int>(
        begin: height,
        end: 0,
      );
}
