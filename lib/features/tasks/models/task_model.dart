enum TaskStatus { pending, inProgress, done }

enum TaskPriority { low, medium, high }

class TaskModel {
  const TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
  });

  final int id;
  final int projectId;
  final String title;
  final String description;
  final TaskStatus status;
  final TaskPriority priority;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    int parseId(dynamic v) => v is int ? v : int.tryParse(v.toString()) ?? 0;
    final id = parseId(json['id']);
    return TaskModel(
      id: id,
      projectId: parseId(json['postId']),
      title: json['name'] as String,
      description: json['body'] as String,
      status: _statusFromId(id),
      priority: _priorityFromId(id),
    );
  }

  static TaskStatus _statusFromId(int id) => switch (id % 3) {
    0 => TaskStatus.done,
    1 => TaskStatus.pending,
    _ => TaskStatus.inProgress,
  };

  static TaskPriority _priorityFromId(int id) => switch (id % 3) {
    0 => TaskPriority.high,
    1 => TaskPriority.medium,
    _ => TaskPriority.low,
  };

  TaskModel copyWith({TaskStatus? status, TaskPriority? priority}) => TaskModel(
    id: id,
    projectId: projectId,
    title: title,
    description: description,
    status: status ?? this.status,
    priority: priority ?? this.priority,
  );
}
