import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/impl/bootstrapper_impl.dart';
import 'constants/environment_constants.dart';
import 'router/router.dart';

void main() async {
  await BootstrapperImpl()
      .boot(
    useEmulators: kDebugMode,
  )
      .then((container) {
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
          title: appName ?? '',
        ),
      ),
    );
  });
}
