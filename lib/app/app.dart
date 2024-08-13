import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/bindings/controller_bindings.dart';
import 'package:task_manager_app/ui/screens/auth/splash_screen.dart';
import 'package:task_manager_app/ui/utility/app_themes.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      home: const SplashScreen(),
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
    );
  }
}
