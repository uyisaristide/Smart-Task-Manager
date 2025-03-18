import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/task_model.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState.initial());

  // Simulate a Dio instance or data fetching
  final List<TaskModel> _taskList = [];

  void addTask(TaskModel task) {
    _taskList.add(task);
    state = state.copyWith(tasks: _taskList);
  }

  void updateTask(String taskId, TaskModel updatedTask) {
    final taskIndex = _taskList.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _taskList[taskIndex] = updatedTask;
      state = state.copyWith(tasks: _taskList);
    }
  }

  void removeTask(String taskId) {
    _taskList.removeWhere((task) => task.id == taskId);
    state = state.copyWith(tasks: _taskList);
  }

  void markTaskCompleted(String taskId) {
    final taskIndex = _taskList.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _taskList[taskIndex] = _taskList[taskIndex].copyWith(completed: true);
      state = state.copyWith(tasks: _taskList);
    }
  }

  Future<void> fetchTasks() async {
    // Simulate a network request or database fetching
    await Future.delayed(Duration(seconds: 2));
    state = state.copyWith(isLoading: true);

    // Add some mock tasks for example purposes
    _taskList.addAll([
      TaskModel(
        id: '1',
        title: 'Task 1',
        description: 'Description for Task 1',
        startDateTime: DateTime.now(),
        stopDateTime: DateTime.now().add(Duration(hours: 1)),
      ),
      TaskModel(
        id: '2',
        title: 'Task 2',
        description: 'Description for Task 2',
        startDateTime: DateTime.now(),
        stopDateTime: DateTime.now().add(Duration(hours: 2)),
      ),
    ]);

    state = state.copyWith(isLoading: false, tasks: _taskList);
  }

  void sortTasksByDate() {
    state = state.copyWith(
      tasks: List.from(state.tasks)..sort((a, b) => a.startDateTime!.compareTo(b.startDateTime)),
    );
  }

  void showCompletedTasks() {
    state = state.copyWith(
      tasks: state.tasks.where((task) => task.completed).toList(),
    );
  }

  void showPendingTasks() {
    state = state.copyWith(
      tasks: state.tasks.where((task) => !task.completed).toList(),
    );
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      fetchTasks(); // Load all tasks if the search query is empty
    } else {
      state = state.copyWith(
        tasks: state.tasks
            .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}

class TaskState {
  final List<TaskModel> tasks;
  final bool isLoading;

  TaskState({required this.tasks, required this.isLoading});

  factory TaskState.initial() => TaskState(tasks: [], isLoading: false);

  TaskState copyWith({List<TaskModel>? tasks, bool? isLoading}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
