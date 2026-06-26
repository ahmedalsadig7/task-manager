import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'tasks_notifier.dart';
export 'tasks_state_providers.dart';

final tasksNotifierProvider =
    AsyncNotifierProvider<TasksNotifier, List<TaskModel>>(
  TasksNotifier.new,
);
