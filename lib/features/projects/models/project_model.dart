enum ProjectStatus { active, inProgress, done }

class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
  });

  final int id;
  final int userId;
  final String title;
  final String description;
  final ProjectStatus status;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    return ProjectModel(
      id: id,
      userId: json['userId'] as int,
      title: json['title'] as String,
      description: json['body'] as String,
      status: _statusFromId(id),
    );
  }

  ProjectModel copyWith({ProjectStatus? status}) => ProjectModel(
    id: id,
    userId: userId,
    title: title,
    description: description,
    status: status ?? this.status,
  );

  static ProjectStatus _statusFromId(int id) => switch (id % 3) {
    0 => ProjectStatus.done,
    1 => ProjectStatus.active,
    _ => ProjectStatus.inProgress,
  };
}
