import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../features/profile/views/profile_screen.dart';
import '../features/projects/views/projects_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _screens = [
    ProjectsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SalomonBottomBar(
              backgroundColor: theme.colorScheme.surface,
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
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
          ),
        ),
      ),
    );
  }
}
