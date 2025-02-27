import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../analytics/tracker.dart';
import '../../di/providers/analytics_provides.dart';

class BaseScreenController {
  final Ref ref;
  late final Tracker tracker;

  BaseScreenController(
    this.ref,
  ) {
    tracker = ref.read(trackerProvider);
  }

  void initialize() {}

  void build(BuildContext context) {}
  void onClose() {}

  void dispose() {
    onClose();
  }
}
