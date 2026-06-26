import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/view_models/auth_providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (_, next) {
      next.whenOrNull(
        data: (user) =>
            user != null ? context.go('/projects') : context.go('/login'),
        error: (_, __) => context.go('/login'),
      );
    });

    return const Scaffold(
      backgroundColor: AppTheme.cream,
      body: Center(child: AppLogo(size: 52)),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Task',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Icon(
            Icons.check_circle_rounded,
            size: size * 0.85,
            color: const Color(0xFFF5A623),
          ),
        ),
        Text(
          'Manager',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
            height: 1,
          ),
        ),
      ],
    );
  }
}
