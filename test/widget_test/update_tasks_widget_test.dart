import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/views/pages/update_task_screen.dart';

void main() {
  group('UpdateTaskScreen Widget Tests', () {
    late TaskModel taskModel;

    setUp(() {
      taskModel = TaskModel(
        id: '1',
        title: 'Initial Task',
        description: 'Initial Description',
        completed: false,
        startDateTime: DateTime(2024, 1, 1),
        stopDateTime: DateTime(2024, 1, 2),
      );
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UpdateTaskScreen(taskModel: taskModel),
        ),
      );

      expect(find.text('Update Task'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Update'), findsOneWidget);
    });

    testWidgets('updates text fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UpdateTaskScreen(taskModel: taskModel),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'New Task Title');
      await tester.enterText(find.byType(TextField).at(1), 'New Task Description');

      expect(find.text('New Task Title'), findsOneWidget);
      expect(find.text('New Task Description'), findsOneWidget);
    });

    testWidgets('taps update button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UpdateTaskScreen(taskModel: taskModel),
        ),
      );

      await tester.tap(find.text('Update'));
      await tester.pump();

      // Here you can add verification for expected outcomes after the button is tapped
    });
  });
}
