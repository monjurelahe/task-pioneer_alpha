// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/repository_controller.dart';
import 'details_page.dart';

class HomePage extends GetView<RepositoryController> {
  // Extends GetView for controller access
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 50 Flutter Repositories'),
        actions: [
          Obx(() {
            final sortOption = controller.currentSortOption.value;
            return IconButton(
              // Sorting button/icon allows users to toggle sorting order. [cite: 16]
              icon: Icon(
                sortOption == SortOption.stars ? Icons.star : Icons.update,
              ),
              onPressed: controller.toggleSortOption,
              tooltip:
                  'Sort by ${sortOption == SortOption.stars ? 'Update Date' : 'Stars'}',
            );
          }),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchAndLoadRepositories,
          ),
        ],
      ),
      // Obx rebuilds only when the observable changes
      body: Obx(() {
        if (controller.isLoading.value && controller.repositories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.repositories.isEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value ?? 'No repositories found.',
            ),
          );
        }

        // Show error message as a snackbar if available (e.g., API failed, but cached data loaded)
        if (controller.errorMessage.value != null &&
            !controller.isLoading.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.snackbar(
              "Warning",
              controller.errorMessage.value!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.yellow[100],
            );
          });
        }

        // Display a list of repositories [cite: 12]
        return ListView.builder(
          itemCount: controller.sortedRepositories.length,
          itemBuilder: (context, index) {
            final repo = controller.sortedRepositories[index];
            return ListTile(
              // Display key details (name, owner, stars, last update) [cite: 12]
              leading: CircleAvatar(
                backgroundImage: NetworkImage(repo.owner.avatarUrl),
              ),
              title: Text(
                repo.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${repo.owner.login}\n${repo.description}'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16),
                      const SizedBox(width: 4),
                      Text(repo.stargazersCount.toString()),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: ${DateFormat('MM-dd-yyyy').format(repo.updatedAt)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                // Navigate to a detailed page [cite: 19]
                Get.to(() => DetailsPage(repository: repo));
              },
            );
          },
        );
      }),
    );
  }
}
