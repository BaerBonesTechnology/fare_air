import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_air/presentation/di/service_controllers/location_state_controller.dart';
import 'package:fare_air/services/impl/location_service_impl.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../analytics/impl/tracker_impl.dart';
import '../../constants/environment_constants.dart';
import '../../firebase_options.dart';
import '../../models/content/home_screen_content.dart';
import '../../presentation/di/providers/analytics_provides.dart';
import '../../presentation/di/providers/content_providers.dart';
import '../../presentation/di/providers/core_providers.dart';
import '../../presentation/di/providers/firebase_providers.dart';
import '../../presentation/di/service_controllers/auth_state_controller.dart';
import '../../services/auth_service.dart';
import '../bootstrapper.dart';

class BootstrapperImpl implements Bootstrapper {
  @override
  Future<ProviderContainer> boot({
    bool useEmulators = false,
  }) async {
    debugPrint('Starting application');
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint(config?.toJson().toString());

    assert(config != null, throw Exception('Application config is not set'));

    await Firebase.initializeApp(
      name: appName ?? 'Habit Tracker',
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      debugPrint('Firebase initialized');
    });

    if (kDebugMode) {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.debug,
        appleProvider: AppleProvider.debug,
      );
    } else {
      await FirebaseAppCheck.instance.activate();
    }

    final prefs = await SharedPreferences.getInstance();

    ProviderContainer container = ProviderContainer(overrides: [
      // Add provider overrides here
      sharedPreferencesProvider.overrideWith((ref) => prefs),
      firebaseAnalyticsProvider
          .overrideWith((ref) => FirebaseAnalytics.instance),
      firestoreProvider.overrideWith((ref) => FirebaseFirestore.instance),
      firebaseAuthProvider.overrideWith((ref) => FirebaseAuth.instance),
      databaseProvider.overrideWith((ref) => FirebaseDatabase.instance),
      remoteConfigProvider.overrideWith((ref) => FirebaseRemoteConfig.instance),
      storageProvider.overrideWith((ref) => FirebaseStorage.instance),
      trackerProvider.overrideWith(
          (ref) => TrackerImpl(ref.read(firebaseAnalyticsProvider))),
      authProvider.overrideWith(
        (ref) => AuthStateController(AuthenticationService(
          ref.read(firebaseAuthProvider),
          ref.read(firebaseAnalyticsProvider),
          ref.read(sharedPreferencesProvider),
        )),
      ),
      locationProvider.overrideWith(
        (ref) => LocationStateController(
          LocationServiceImpl(ref.read(sharedPreferencesProvider)),
        ),
      ),
      homeScreenContentProvider.overrideWith((ref) => HomeScreenContent()),
    ]);

    if (useEmulators) {
      await _startEmulators(container);
    }

    container.read(locationProvider)?.checkPermissions();

    return container;
  }

  Future<void> _startEmulators(ProviderContainer ref) async {
    if (kDebugMode) {
      // Set analytics to not collect data during development
      // This is useful when running the app in an emulator
      final analytics = ref.read(firebaseAnalyticsProvider);
      final auth = ref.read(firebaseAuthProvider);
      final firestore = ref.read(firestoreProvider);
      final database = ref.read(databaseProvider);
      final storage = ref.read(storageProvider);

      analytics?.logEvent(name: 'emulator_start');

      analytics?.setAnalyticsCollectionEnabled(false);
      analytics?.setSessionTimeoutDuration(const Duration(seconds: 5));

      // Set Firebase Emulators
      firestore?.useFirestoreEmulator('localhost', 8081);
      auth?.useAuthEmulator('localhost', 9099);
      database?.useDatabaseEmulator('localhost', 9000);
      storage?.useStorageEmulator('localhost', 9000);
    }
  }
}
