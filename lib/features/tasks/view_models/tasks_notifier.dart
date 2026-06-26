import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../../projects/view_models/projects_providers.dart';
import '../models/task_model.dart';
import 'tasks_state_providers.dart';

class TasksNotifier extends AsyncNotifier<List<TaskModel>> {
  @override
  Future<List<TaskModel>> build() async {
    final projectId = ref.watch(currentProjectIdProvider);
    if (projectId == 0) return [];
    return ref.read(tasksRepositoryProvider).getTasksForProject(projectId);
  }

  Future<void> markDone(int taskId) async {
    final projectId = ref.read(currentProjectIdProvider);
    state = state.whenData(
      (tasks) => tasks
          .map((t) => t.id == taskId ? t.copyWith(status: TaskStatus.done) : t)
          .toList(),
    );

    final allDone = state.asData?.value.every((t) => t.status == TaskStatus.done) ?? false;
    if (allDone) {
      ref.read(projectsNotifierProvider.notifier).markProjectDone(projectId);
    }

    try {
      await ref.read(tasksRepositoryProvider).markTaskDone(taskId);
    } catch (_) {
      state = await AsyncValue.guard(
        () => ref.read(tasksRepositoryProvider).getTasksForProject(projectId),
      );
    }
  }

  Future<void> addTask(String title, TaskPriority priority) async {
    final projectId = ref.read(currentProjectIdProvider);
    final newTask = await ref
        .read(tasksRepositoryProvider)
        .addTask(projectId, title, priority);
    state = state.whenData((tasks) => [newTask, ...tasks]);
  }
}
