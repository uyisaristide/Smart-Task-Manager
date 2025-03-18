import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/views/pages/new_task_screen.dart';

import 'common/local_tree.dart'; // Adjust with the correct import path

void main() {
  testWidgets('NewTaskScreen renders correctly', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Verify that certain widgets are present
    expect(find.byType(TableCalendar), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('NewTaskScreen selects a date range', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Open the calendar and select a range (adjust the day selection as needed)
    await tester.tap(find.byType(TableCalendar));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15')); // Select a start day
    await tester.tap(find.text('18')); // Select an end day
    await tester.pumpAndSettle();

    // Verify that the date range is displayed
    expect(find.text('Task starting at 2023-03-15 - 2023-03-18'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Title text field input', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Enter text into the Title field
    await tester.enterText(find.byType(TextField).at(0), 'Test Task');
    await tester.pump();

    // Verify that the text is entered
    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Description text field input', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Enter text into the Description field
    await tester.enterText(find.byType(TextField).at(1), 'Test Description');
    await tester.pump();

    // Verify that the text is entered
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Cancel button behavior', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Tap the Cancel button
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the screen pops (Navigator.pop should be called)
    expect(find.byType(NewTaskScreen), findsNothing);
  });

  testWidgets('NewTaskScreen Save button behavior', (WidgetTester tester) async {
    // Use your custom widget tree for rendering
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    // Tap the Save button
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the Save button triggers the intended behavior (e.g., data saving).
    // You would typically mock a save operation and verify that it occurred here.
  });
}
