import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'constants/colors.dart';
import 'routes/router.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
          primarySwatch: primarySwatch,
          colorScheme: ColorScheme.fromSeed(seedColor: primarySwatch),
          primaryColor: primarySwatch,
          scaffoldBackgroundColor: scaffold,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.black87)),
          cardTheme: CardTheme(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          snackBarTheme: const SnackBarThemeData(
              backgroundColor: primarySwatch,
              contentTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          bottomSheetTheme: const BottomSheetThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primarySwatch),
                padding: WidgetStateProperty.all(const EdgeInsets.all(14)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32))),
                elevation: WidgetStateProperty.all(0),
              )),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.2,
                  color: Colors.grey),
              borderRadius: BorderRadius.circular(3),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.2,
                  color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.2,
                  color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          dialogTheme: DialogTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  textStyle: const TextStyle(color: primarySwatch),
                  foregroundColor: primarySwatch,
                  side: const BorderSide(color: primarySwatch),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32))))),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
