import '../../../core/network/http_client.dart';
import '../models/task_model.dart';

class TasksRepository {
  const TasksRepository(this._client);

  final AppHttpClient _client;

  Future<List<TaskModel>> getTasksForProject(int projectId) async {
    final data = await _client.get('/posts/$projectId/comments');
    final list = data as List<dynamic>;
    return list
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TaskModel> addTask(
      int projectId, String title, TaskPriority priority) async {
    final data = await _client.post(
      '/posts/$projectId/comments',
      body: {
        'postId': projectId,
        'name': title,
        'email': 'user@taskmanager.com',
        'body': '',
      },
    );
    return TaskModel.fromJson(data as Map<String, dynamic>)
        .copyWith(status: TaskStatus.pending, priority: priority);
  }

  Future<void> markTaskDone(int taskId) async {
    await _client.patch('/comments/$taskId', body: {'completed': true});
  }
}
