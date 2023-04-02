
class UserModel {
  final String name;
  final String bio;
  final String profilePic;
  final String userId;
  final String phoneNumber;
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
