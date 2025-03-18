import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/providers/notifiers/task_notifier.dart';
import 'package:task_manager/providers/riverpod_providers/tasks_provider.dart';
import 'package:task_manager/views/pages/tasks_screen.dart';
import 'package:task_manager/views/widgets/task_item_view.dart';

import 'common/local_tree.dart';



// MockTaskNotifier definition
class MockTaskNotifier extends StateNotifier<TaskState> with Mock
    implements TaskNotifier {
  MockTaskNotifier() : super(TaskState.initial());

  void setTasks(List<TaskModel> tasks) {
    state = state.copyWith(tasks: tasks, isLoading: false);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  @override
  void addTask(TaskModel task) {
    // TODO: implement addTask
  }

  @override
  Future<void> fetchTasks() {
    // TODO: implement fetchTasks
    throw UnimplementedError();
  }

  @override
  void markTaskCompleted(String taskId) {
    // TODO: implement markTaskCompleted
  }

  @override
  void removeTask(String taskId) {
    // TODO: implement removeTask
  }

  @override
  void searchTasks(String query) {
    // TODO: implement searchTasks
  }

  @override
  void showCompletedTasks() {
    // TODO: implement showCompletedTasks
  }

  @override
  void showPendingTasks() {
    // TODO: implement showPendingTasks
  }

  @override
  void sortTasksByDate() {
    // TODO: implement sortTasksByDate
  }

  @override
  void updateTask(String taskId, TaskModel updatedTask) {
    // TODO: implement updateTask
  }
}

// Your test cases
void main() {
  testWidgets("TasksScreen UI renders correctly", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    final container = ProviderContainer(overrides: [
      taskProvider.overrideWith((ref) => mockTaskNotifier),
    ]);

    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    // Verify AppBar title
    expect(find.text('Hi Aristide'), findsOneWidget);

    // Verify search field is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify floating action button exists
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets("Search field updates on text entry", (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    final searchField = find.byType(TextField);
    await tester.enterText(searchField, "Test Task");

    expect(find.text("Test Task"), findsOneWidget);
  });

  testWidgets("Displays loading indicator when tasks are loading", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    mockTaskNotifier.setLoading(true);

    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Displays list of tasks when loaded", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    mockTaskNotifier.setTasks([
      TaskModel(
        id: 'task_3',
        title: 'Bug Fix: Navigation Issue',
        description: 'Fix the issue with navigation in the app.',
        startDateTime: DateTime(2025, 3, 17, 14, 0),
        stopDateTime: DateTime(2025, 3, 17, 16, 0),
        completed: true,
      ),
      TaskModel(
        id: 'task_4',
        title: 'Prepare meeting agenda',
        description: 'Draft the agenda for tomorrow’s meeting with stakeholders.',
        startDateTime: DateTime(2025, 3, 19, 8, 0),
        stopDateTime: DateTime(2025, 3, 19, 9, 0),
        completed: false,
      ),
    ]);

    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.pump();

    expect(find.byType(TaskItemView), findsNWidgets(2));
    expect(find.text("Bug Fix: Navigation Issue"), findsOneWidget);
    expect(find.text("Prepare meeting agenda"), findsOneWidget);
  });

  testWidgets("Displays empty state message when no tasks are found", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    mockTaskNotifier.setTasks([]);

    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.pump();

    expect(find.text("No tasks available"), findsOneWidget);
  });

  testWidgets("Sorting tasks by date from popup menu", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Sort by date"));
    await tester.pump();

    verify(mockTaskNotifier.sortTasksByDate()).called(1);
  });

  testWidgets("Shows completed tasks from popup menu", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Completed tasks"));
    await tester.pump();

    verify(mockTaskNotifier.showCompletedTasks()).called(1);
  });

  testWidgets("Shows pending tasks from popup menu", (WidgetTester tester) async {
    final mockTaskNotifier = MockTaskNotifier();
    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.tap(find.byType(PopupMenuButton<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Pending tasks"));
    await tester.pump();

    verify(mockTaskNotifier.showPendingTasks()).called(1);
  });

  testWidgets("Navigates to create task screen when FAB is pressed", (WidgetTester tester) async {
    final mockRouter = MockGoRouter();

    await tester.pumpWidget(myWidgetTree(widgetToTest: TasksScreen()));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    verify(mockRouter.go("/createTask")).called(1);
  });
}
