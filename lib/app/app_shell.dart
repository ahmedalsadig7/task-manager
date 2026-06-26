import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = location.startsWith('/profile') ? 1 : 0;
    final showBottomBar = location == '/projects' || location == '/profile';
    final theme = Theme.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomBar ? Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(18),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 0) context.go('/projects');
            if (index == 1) context.go('/profile');
          },
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          selectedItemColor: theme.colorScheme.onSurface,
          unselectedItemColor: theme.colorScheme.outline,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_rounded),
              title: const Text('Home'),
              selectedColor: theme.colorScheme.onSurface,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_rounded),
              title: const Text('Profile'),
              selectedColor: theme.colorScheme.onSurface,
            ),
          ],
        ),
      ) : null,
    );
  }
}
