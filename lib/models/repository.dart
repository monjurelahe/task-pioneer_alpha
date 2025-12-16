// lib/models/repository.dart

import 'owner.dart';

class Repository {
  final int id;
  final String name;
  final String fullName;
  final Owner owner;
  final String description;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final String language;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String htmlUrl;

  Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.description,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.language,
    required this.updatedAt,
    required this.createdAt,
    required this.htmlUrl,
  });

  // Factory constructor to create Repository from JSON (GitHub API response)
  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>? ?? {}),
      description: json['description'] as String? ?? '',
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      watchersCount: json['watchers_count'] as int? ?? 0,
      forksCount: json['forks_count'] as int? ?? 0,
      language: json['language'] as String? ?? '',
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      htmlUrl: json['html_url'] as String? ?? '',
    );
  }

  // Convert Repository to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'owner': owner.toJson(),
      'description': description,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'forks_count': forksCount,
      'language': language,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'html_url': htmlUrl,
    };
  }
}
