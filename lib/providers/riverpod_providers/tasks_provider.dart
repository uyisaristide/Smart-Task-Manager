import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/task_notifier.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier();
});