import '../../constants/environment_constants.dart';
import '../../models/content/home_screen_content.dart';
import '../di/providers/core_providers.dart';
import '../di/service_controllers/auth_state_controller.dart';
import 'base_screen_controller.dart';

class HomeScreenController extends BaseScreenController {
  HomeScreenController(super.ref) : super();

  late final AuthStateController? _auth;
  late final HomeScreenContent? content;
  late String _header;

  @override
  void initialize() {
    _auth = ref.watch(authProvider);
    // Set content for the home screen
    _header = 'Welcome to $appName';

    if (_auth?.state != null) {
      if (_auth?.state?.isAnonymous == true) {}
    } else {
      throw Exception('User is not authenticated');
    }
    tracker.logEvent('home_screen_opened');
    super.initialize();
  }

  @override
  void build() {
    content = HomeScreenContent(
      header: _header,
    );
  }
}
