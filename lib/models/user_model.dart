import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)

class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String bio;
  @HiveField(2)
  final String profilePic;
  @HiveField(3)
  final String userId;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final bool isOnline;
  // final List<String> groupId;

  UserModel({
    required this.name,
    required this.bio,
    required this.profilePic,
    required this.userId,
    required this.phoneNumber,
    required this.isOnline,
    // required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'profilePic': profilePic,
      'userId': userId,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      //'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      userId: map['userId'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      //groupId: List<String>.from(map['groupId']),
    );
  }
}
