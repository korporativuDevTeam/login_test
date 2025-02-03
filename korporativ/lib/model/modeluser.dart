// user_model.dart
class User {
  final int id;
  final String name;
  final String email;
  final String? imageUrl;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json, {required String token}) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['image'] ?? 'images/logo.jpg',
      token: token,
    );
  }
}
