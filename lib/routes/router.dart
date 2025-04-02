import 'package:go_router/go_router.dart';

import '../model/task_model.dart';
import '../page_not_found.dart';
import '../views/auth_screens/login.dart';
import '../views/auth_screens/register.dart';
import '../splash_screen.dart';
import '../views/task/new_task_screen.dart';
import '../views/task/tasks_screen.dart';
import '../views/task/update_task_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    // Splash Screen Route
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      path: '/newUser',
      builder: (context, state) =>  RegisterScreen(),
    ),
    // Tasks Screen Route
    GoRoute(
      path: '/home',
      builder: (context, state) => const TasksScreen(),
    ),

    // Create New Task Route
    GoRoute(
      path: '/createTask',
      builder: (context, state) => const NewTaskScreen(),
    ),


    GoRoute(
        path: '/updateTask',
        builder: (context, state) {
          final task = state.extra as TaskModel;
          return UpdateTaskScreen(taskModel: task);
        }),
    // Catch-all route for 404 (Page Not Found)
    GoRoute(
      path: '/404',
      builder: (context, state) => const PageNotFound(),
    ),
  ],
);


