import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/auth_notifier.dart';
import '../notifiers/task_notifier.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});


final userProvider = StateNotifierProvider<UserNotifier, UserState?>((ref) {
  return UserNotifier();
});

