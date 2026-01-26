class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final bool isOnline;
  final String lastSeen;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.isOnline = false,
    required this.lastSeen,
  });

  // Convertir JSON en objet User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      isOnline: json['is_online'] == 1 || json['is_online'] == true,
      lastSeen: json['last_seen'] ?? '',
    );
  }

  // Convertir objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'is_online': isOnline,
      'last_seen': lastSeen,
    };
  }
}