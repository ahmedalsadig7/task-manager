import '../../../core/network/http_client.dart';
import '../models/project_model.dart';

class ProjectsRepository {
  const ProjectsRepository(this._client);

  final AppHttpClient _client;

  Future<List<ProjectModel>> getProjects() async {
    final data = await _client.get('/posts');
    final list = data as List<dynamic>;
    return list
        .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
