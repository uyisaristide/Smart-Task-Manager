import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

Widget myWidgetTree({required Widget widgetToTest}) {
  return ProviderScope(
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: getGoRouter(widgetToTest),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
    ),
  );
}

GoRouter getGoRouter(Widget w) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => w,
      ),
    ],
  );
}
