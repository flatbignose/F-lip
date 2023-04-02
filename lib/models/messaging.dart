import 'package:flip_first_build/enums/chat_enum.dart';

class Messaging {
  final String senderId;
  final String recieverId;
  final String messageId;
  final String message;
  final ChatEnum type;
  final DateTime timeSent;
  final bool isSeen;

  Messaging({
    required this.senderId,
    required this.recieverId,
    required this.messageId,
    required this.message,
    required this.type,
    required this.timeSent,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'messageId': messageId,
      'message': message,
      'type': type.type,
      'isSeen': isSeen,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory Messaging.fromMap(Map<String, dynamic> map) {
    return Messaging(
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      messageId: map['messageId'] ?? '',
      message: map['message'] ?? '',
      
      type: (map['type'] as String)
          .toEnum(), //check fully, if required use the extension
      isSeen: map['isSeen'] ?? false,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
