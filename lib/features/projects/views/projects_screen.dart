import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/error_handler.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../models/project_model.dart';
import '../view_models/projects_providers.dart';
import 'widgets/project_card.dart';

final _skeletonProjects = List.generate(
  6,
  (i) => ProjectModel(
    id: i,
    userId: 1,
    title: 'Loading project title here',
    description: 'Loading project description that spans two lines of text here',
    status: ProjectStatus.active,
  ),
);

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: projectsAsync.when(
        loading: () => Skeletonizer(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 90),
            itemCount: _skeletonProjects.length,
            itemBuilder: (context, index) => ProjectCard(
              project: _skeletonProjects[index],
              onTap: () {},
            ),
          ),
        ),
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
