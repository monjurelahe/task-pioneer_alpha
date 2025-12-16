// lib/services/persistence_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/repository.dart';

class PersistenceService {
  static const _repoKey = 'cached_repositories';
  static const _sortKey = 'last_sort_option'; // Persistence key for sorting

  late final SharedPreferences _prefs;

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save fetched data locally [cite: 9, 27]
  Future<void> saveRepositories(List<Repository> repos) async {
    final jsonList = repos.map((repo) => repo.toJson()).toList();
    await _prefs.setString(_repoKey, jsonEncode(jsonList));
  }

  // Retrieve locally saved data [cite: 9, 27]
  List<Repository>? loadRepositories() {
    final jsonString = _prefs.getString(_repoKey);

    if (jsonString == null) return null;

    final List jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Repository.fromJson(json)).toList();
  }

  // Persist the selected sorting option across app sessions
  Future<void> saveSortOption(String option) async {
    await _prefs.setString(_sortKey, option);
  }

  // Load the persisted sorting option
  String? loadSortOption() {
    return _prefs.getString(_sortKey);
  }
}
