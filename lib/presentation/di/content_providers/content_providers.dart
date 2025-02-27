import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cms/controllers/home_screen_controller.dart';
import 'home_content_controller.dart';

StateProvider<HomeContentStateController?> homeScreenContentProvider =
    StateProvider<HomeContentStateController?>((ref) {
  return HomeContentStateController(
    HomeScreenController(ref),
  );
});
