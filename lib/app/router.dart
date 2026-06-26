import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/view_models/auth_providers.dart';
import '../features/auth/views/login_screen.dart';
import '../features/auth/views/register_screen.dart';
import '../features/tasks/views/project_details_screen.dart';
import '../splash_screen.dart';
import 'main_screen.dart';

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authNotifierProvider, (_, __) => notifyListeners());
  }
  final Ref _ref;
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authAsync = ref.read(authNotifierProvider);
      final loc = state.matchedLocation;
      final onSplash = loc == '/';
      final onAuthRoute = loc == '/login' || loc.startsWith('/register');

      return authAsync.when(
        loading: () => (onAuthRoute || onSplash) ? null : '/',
        error: (_, __) => onAuthRoute ? null : '/login',
        data: (user) {
          final isAuth = user != null;
          if (isAuth && (onSplash || onAuthRoute)) return '/projects';
          if (!isAuth && !onAuthRoute && !onSplash) return '/login';
          return null;
        },
      );
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/projects', builder: (_, __) => const MainScreen()),
      GoRoute(
        path: '/projects/:id',
        builder: (_, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return ProjectDetailsScreen(projectId: id);
        },
      ),
    ],
  );
});
