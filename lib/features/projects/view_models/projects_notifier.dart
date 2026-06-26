import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../models/project_model.dart';

class ProjectsNotifier extends AsyncNotifier<List<ProjectModel>> {
  @override
  Future<List<ProjectModel>> build() async {
    return ref.read(projectsRepositoryProvider).getProjects();
  }

  void markProjectDone(int projectId) {
    state = state.whenData(
      (projects) => projects
          .map((p) => p.id == projectId
              ? p.copyWith(status: ProjectStatus.done)
              : p)
          .toList(),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(projectsRepositoryProvider).getProjects(),
    );
  }
}
