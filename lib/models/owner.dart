// lib/models/owner.dart

class Owner {
  final String login;
  final String avatarUrl;
  final int id;

  Owner({required this.login, required this.avatarUrl, required this.id});

  // Factory constructor to create Owner from JSON
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      id: json['id'] as int? ?? 0,
    );
  }

  // Convert Owner to JSON for persistence
  Map<String, dynamic> toJson() {
    return {'login': login, 'avatar_url': avatarUrl, 'id': id};
  }
}
