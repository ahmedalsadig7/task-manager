import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/error_handler.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_loading_widget.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../projects/view_models/projects_providers.dart';
import '../view_models/tasks_providers.dart';
import 'widgets/add_task_bottom_sheet.dart';
import 'widgets/task_card.dart';

class ProjectDetailsScreen extends ConsumerStatefulWidget {
  const ProjectDetailsScreen({super.key, required this.projectId});

  final int projectId;

  @override
  ConsumerState<ProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends ConsumerState<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentProjectIdProvider.notifier).set(widget.projectId);
    });
  }

  void _showAddTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksNotifierProvider);

    final projectTitle = ref
        .watch(projectsNotifierProvider)
        .asData
        ?.value
        .firstWhere(
          (p) => p.id == widget.projectId,
          orElse: () => throw StateError(''),
        )
        .title;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          projectTitle ?? 'Project Details',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTask,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
        backgroundColor: Colors.white,
      ),
      body: tasksAsync.when(
        loading: () => const AppLoadingWidget(),
        error: (e, _) => AppErrorWidget(
          message: formatError(e),
          onRetry: () =>
              ref.read(currentProjectIdProvider.notifier).set(widget.projectId),
        ),
        data: (tasks) {
          if (tasks.isEmpty) {
            return const EmptyStateWidget(
              message: 'No tasks yet.\nTap + to add one.',
              icon: Icons.checklist_outlined,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 88, top: 8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                task: task,
                onMarkDone: () =>
                    ref.read(tasksNotifierProvider.notifier).markDone(task.id),
              );
            },
          );
        },
      ),
    );
  }
}
