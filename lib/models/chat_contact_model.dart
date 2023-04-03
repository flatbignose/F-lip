import 'package:hive_flutter/hive_flutter.dart';
part 'chat_contact_model.g.dart';

@HiveType(typeId: 2)
class ChatContactTile {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String profilePic;
  @HiveField(2)
  final String contactId;
  @HiveField(3)
  final DateTime timeSent;
  @HiveField(4)
  final String lastMessage;

  ChatContactTile({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContactTile.fromMap(Map<String, dynamic> map) {
    return ChatContactTile(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
