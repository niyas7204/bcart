// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final UserModel user;

  User({required this.user});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserModel {
  final String userId;
  final String userName;
  final String email;
  final String? address;
  final String userType;

  UserModel(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.userType,
      required this.address});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': userId,
      'name': userName,
      'email': email,
      'address': address,
      'userType': userType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['_id'] as String,
      userName: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      userType: map['userType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
