// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatContactTileAdapter extends TypeAdapter<ChatContactTile> {
  @override
  final int typeId = 2;

  @override
  ChatContactTile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatContactTile(
      name: fields[0] as String,
      profilePic: fields[1] as String,
      contactId: fields[2] as String,
      timeSent: fields[3] as DateTime,
      lastMessage: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatContactTile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.profilePic)
      ..writeByte(2)
      ..write(obj.contactId)
      ..writeByte(3)
      ..write(obj.timeSent)
      ..writeByte(4)
      ..write(obj.lastMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatContactTileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
