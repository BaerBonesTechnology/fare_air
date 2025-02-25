import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../analytics/tracker.dart';
import '../di/providers/analytics_provides.dart';

class BaseScreenController {
  final WidgetRef ref;
  late final Tracker tracker;

  BaseScreenController(
    this.ref,
  ) {
    tracker = ref.read(trackerProvider);
    initialize();
  }

  void initialize() {
    build();
  }

  void build() {}
  void onClose() {}

  void dispose() {
    onClose();
  }
}
