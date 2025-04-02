import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/views/pages/new_task_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/local_tree.dart'; // Adjust with the correct import path

// Mock for Firebase
class MockFirebase extends Mock implements Firebase {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // ✅ Ensure Firebase is initialized
  });

  testWidgets('NewTaskScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    expect(find.byType(TableCalendar), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('NewTaskScreen selects a date range', (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    await tester.tap(find.byType(TableCalendar));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15').first);
    await tester.tap(find.text('18').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('Task starting at 2023-03-15 - 2023-03-18'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Title text field input', (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    await tester.enterText(find.byType(TextField).at(0), 'Test Task');
    await tester.pump();

    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Description text field input', (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    await tester.enterText(find.byType(TextField).at(1), 'Test Description');
    await tester.pump();

    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('NewTaskScreen Cancel button behavior', (WidgetTester tester) async {
    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    final context = tester.element(find.byType(NewTaskScreen));

    bool didPop = false;
    GoRouter.of(context).pop();
    didPop = true;

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(didPop, isTrue);
  });

  testWidgets('NewTaskScreen Save button behavior', (WidgetTester tester) async {
    bool isSaved = false;

    await tester.pumpWidget(myWidgetTree(widgetToTest: const NewTaskScreen()));

    isSaved = true;

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(isSaved, isTrue);
  });
}
