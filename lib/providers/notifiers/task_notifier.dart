import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/task_model.dart';

// Firestore Reference
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _tasksCollection = _firestore.collection('tasks');

// Task Notifier
class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState.initial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TaskModel> _allTasks = []; // Store all tasks for searching

  Future<void> addTask(TaskModel task, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      DocumentReference docRef =
          await _firestore.collection('tasks').add(task.toJson());
      final newTask =
          task.copyWith(id: docRef.id); // Use Firestore-generated ID

      // Update Firestore with the correct ID
      await docRef.update({'id': docRef.id});
      print("✅ Task added successfully: ${newTask.toJson()}");

      state = state.copyWith(tasks: [...state.tasks, newTask]);
    } catch (e) {
      print("Error adding task: $e");
    } finally {
      state = state.copyWith(isLoading: false);
      context.pop();
    }
  }

  Future<void> fetchTasks() async {
    try {
      state = state.copyWith(isLoading: true);
      QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();

      List<TaskModel> tasks = querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      _allTasks = tasks; // Store all tasks for search functionality
      state = state.copyWith(isLoading: false, tasks: tasks);
    } catch (e) {
      print("Error fetching tasks: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      state = state.copyWith(tasks: _allTasks); // Restore full list
    } else {
      List<TaskModel> filteredTasks = _allTasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(tasks: filteredTasks);
    }
  }

  Future<void> updateTask(
      String taskId, TaskModel updatedTask, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update(updatedTask.toJson());
      List<TaskModel> updatedTasks = state.tasks.map((task) {
        return task.id == taskId ? updatedTask : task;
      }).toList();

      state = state.copyWith(tasks: updatedTasks);
    } catch (e) {
      print("Error updating task: $e");
    } finally {
      state = state.copyWith(isLoading: false);
      context.pop();
    }
  }

  Future<void> completeTask(String taskId, TaskModel updatedTask) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update(updatedTask.toJson());
      List<TaskModel> updatedTasks = state.tasks.map((task) {
        return task.id == taskId ? updatedTask : task;
      }).toList();

      state = state.copyWith(tasks: updatedTasks);
    } catch (e) {
      print("Error updating task: $e");
    }
  }
  void sortTasks({String? sortBy, bool ascending = true}) {
    List<TaskModel> sortedTasks = List.from(state.tasks);

    sortedTasks.sort((a, b) {
      int result = 0;

      switch (sortBy) {
        case "completed":
          result = a.completed.toString().compareTo(b.completed.toString());
          break;
        case "startDate":
          result = a.startDateTime.compareTo(b.startDateTime);
          break;
        case "priority":
          result = a.priority.compareTo(b.priority);
          break;
        default:
          return 0;
      }

      return ascending ? result : -result;
    });

    state = state.copyWith(tasks: sortedTasks);
  }
  Future<void> removeTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      state = state.copyWith(
          tasks: state.tasks.where((task) => task.id != taskId).toList());
    } catch (e) {
      print("Error deleting task: $e");
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
