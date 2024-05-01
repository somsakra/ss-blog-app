import 'package:ss_blog_app/core/entities/user.dart';

class UserModel extends User {
  // UserModel({required String id, required String email, required String name})
  //     : super(id: id, email: email, name: name);
  UserModel(
      {required super.id,
      required super.email,
      required super.name}); // same as above
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '');
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
