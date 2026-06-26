import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';
import 'projects_notifier.dart';

final projectsNotifierProvider =
    AsyncNotifierProvider<ProjectsNotifier, List<ProjectModel>>(
  ProjectsNotifier.new,
);
