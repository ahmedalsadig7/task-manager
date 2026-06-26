import '../../../core/network/http_client.dart';
import '../../../core/storage/storage_service.dart';
import '../models/user_model.dart';

// NOTE: JSONPlaceholder has no real auth endpoint. Login is simulated via
// email lookup (GET /users?email=X). Passwords are accepted but not validated
// server-side. Register POSTs to /users but the response is not persisted.
class AuthRepository {
  const AuthRepository(this._client, this._storage);

  final AppHttpClient _client;
  final StorageService _storage;

  Future<UserModel> login(String email, String password) async {
    final data = await _client.get('/users', queryParams: {'email': email});
    final list = data as List<dynamic>;
    if (list.isEmpty) {
      throw Exception('No account found with that email address.');
    }
    final user = UserModel.fromJson(list.first as Map<String, dynamic>);
    await _storage.saveToken(user.id.toString());
    await _storage.saveUser(user.toJson());
    return user;
  }

  Future<UserModel> register(String name, String email, String password) async {
    final data = await _client.post('/users', body: {
      'name': name,
      'email': email,
      'username': name.toLowerCase().replaceAll(' ', '.'),
    });
    final user = UserModel.fromJson(data as Map<String, dynamic>);
    await _storage.saveToken(user.id.toString());
    await _storage.saveUser(user.toJson());
    return user;
  }

  Future<UserModel?> getStoredUser() async {
    final token = await _storage.getToken();
    if (token == null) return null;
    final json = await _storage.getUser();
    if (json == null) return null;
    return UserModel.fromJson(json);
  }
}
