enum ChatEnum {
  message('message'),
  image('image');

  const ChatEnum(this.type);
  final String type;
}

// Using an extension
// Enhanced enums

extension ConvertMessage on String {
  ChatEnum toEnum() {
    switch (this) {
      case 'image':
        return ChatEnum.image;
      case 'message':
        return ChatEnum.message;
      default:
        return ChatEnum.message;
    }
  }
}
