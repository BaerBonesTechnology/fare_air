import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/home_screen.dart';
import '../presentation/screens/splash_screen.dart';

final _auth = FirebaseAuth.instance;
GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => const LoadScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeScreen(),
    ),
  ],
  initialLocation: '/splash',
);

GoRouter get router => _router;
