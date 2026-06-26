import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentProjectIdNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void set(int id) => state = id;
}

final currentProjectIdProvider =
    NotifierProvider<CurrentProjectIdNotifier, int>(
  CurrentProjectIdNotifier.new,
);
