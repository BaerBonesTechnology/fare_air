import 'package:go_router/go_router.dart';

import '../presentation/screens/home_screen.dart';

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeScreen(),
    ),
  ],
  initialLocation: '/',
);

GoRouter get router => _router;
