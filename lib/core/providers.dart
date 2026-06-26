import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/http_client.dart';
import 'storage/storage_service.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/projects/data/projects_repository.dart';
import '../features/tasks/data/tasks_repository.dart';

// Overridden in main.dart with the real instance before runApp.
final sharedPrefsProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('sharedPrefsProvider not overridden'),
);

final httpClientProvider = Provider<AppHttpClient>((_) => AppHttpClient());

final storageServiceProvider = Provider<StorageService>((_) => StorageService());

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(httpClientProvider),
    ref.read(storageServiceProvider),
  ),
);

final projectsRepositoryProvider = Provider<ProjectsRepository>(
  (ref) => ProjectsRepository(ref.read(httpClientProvider)),
);

final tasksRepositoryProvider = Provider<TasksRepository>(
  (ref) => TasksRepository(ref.read(httpClientProvider)),
);
