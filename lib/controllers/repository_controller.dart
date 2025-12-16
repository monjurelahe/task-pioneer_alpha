// lib/controllers/repository_controller.dart

import 'package:get/get.dart';
import '../services/github_service.dart';
import '../services/persistence_service.dart';
import '../models/repository.dart';

enum SortOption { stars, updated }

class RepositoryController extends GetxController {
  final GitHubService _githubService =
      Get.find(); // Dependency injection via Get.find()
  final PersistenceService _persistenceService = Get.find();

  // Observable list of all fetched repositories
  var repositories = <Repository>[].obs;
  // Observable state for loading and error handling
  var isLoading = true.obs;
  var errorMessage = Rxn<String>();

  // Observable for the current sorting option, initialized based on persistence
  var currentSortOption = SortOption.stars.obs;

  // Computed property: returns the repositories list sorted based on currentSortOption
  List<Repository> get sortedRepositories {
    final List<Repository> list = repositories.toList();

    if (currentSortOption.value == SortOption.updated) {
      // Sort by last updated date-time [cite: 14]
      list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } else {
      // Sort by star count (default) [cite: 15]
      list.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
    }
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    // Load persisted sort option when the controller is initialized
    _loadPersistedSortOption();
    // Load data
    fetchAndLoadRepositories();
  }

  void _loadPersistedSortOption() {
    final savedOption = _persistenceService.loadSortOption();
    if (savedOption != null) {
      currentSortOption.value = savedOption == 'updated'
          ? SortOption.updated
          : SortOption.stars;
    }
  }

  Future<void> fetchAndLoadRepositories() async {
    isLoading(true);
    errorMessage(null);

    // 1. Try loading from cache first (Offline Support) [cite: 9, 27]
    final cachedRepos = _persistenceService.loadRepositories();
    if (cachedRepos != null && cachedRepos.isNotEmpty) {
      repositories.value = cachedRepos;
      isLoading(false);
      // We still try to fetch fresh data in the background
    }

    // 2. Fetch fresh data from API
    try {
      final freshRepos = await _githubService.fetchFlutterRepositories();
      if (freshRepos.isNotEmpty) {
        // 3. Save to cache and update state [cite: 9, 27]
        await _persistenceService.saveRepositories(freshRepos);
        repositories.value = freshRepos; // Updates UI via Obx/GetX
      }
    } catch (e) {
      // Show error, but keep cached data if it was loaded
      errorMessage.value = cachedRepos != null
          ? 'Error fetching fresh data. Showing cached data.'
          : 'Failed to load repositories. Check connection.'; // Proper error handling [cite: 37]
    } finally {
      isLoading(false);
    }
  }

  // Toggles between star count and update date sorting [cite: 16]
  void toggleSortOption() {
    final newOption = currentSortOption.value == SortOption.stars
        ? SortOption.updated
        : SortOption.stars;
    currentSortOption.value = newOption; // Update the observable

    // Persist the new sorting option
    _persistenceService.saveSortOption(
      newOption == SortOption.updated ? 'updated' : 'stars',
    );
  }
}
