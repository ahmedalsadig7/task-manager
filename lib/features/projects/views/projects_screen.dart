import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/error_handler.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_loading_widget.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../view_models/projects_providers.dart';
import 'widgets/project_card.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: projectsAsync.when(
        loading: () => const AppLoadingWidget(),
        error: (e, _) => AppErrorWidget(
          message: formatError(e),
          onRetry: () => ref.read(projectsNotifierProvider.notifier).refresh(),
        ),
        data: (projects) {
          if (projects.isEmpty) {
            return const EmptyStateWidget(
              message: 'No projects found.',
              icon: Icons.folder_open_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(projectsNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 90),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(
                  project: project,
                  onTap: () => context.push('/projects/${project.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
