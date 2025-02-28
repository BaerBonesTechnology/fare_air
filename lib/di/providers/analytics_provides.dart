import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../analytics/tracker.dart';

final Provider<Tracker> trackerProvider = Provider<Tracker>((ref) {
  return Tracker();
});
