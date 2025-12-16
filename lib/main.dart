// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/repository_controller.dart';
import 'screens/home_page.dart';
import 'services/github_service.dart';
import 'services/persistence_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Persistence Service (before controller)
  final persistenceService = PersistenceService();
  await persistenceService.init();

  // 2. Dependency Injection using GetX
  Get.put(GitHubService());
  Get.put(persistenceService);
  Get.put(RepositoryController()); // Inject the main controller

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetMaterialApp for GetX routing and utilities
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Repos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // Theme implementation [cite: 44]
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
