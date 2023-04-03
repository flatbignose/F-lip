import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/auth/controller/auth_controller.dart';
import 'package:flip_first_build/chat_section/repos/chat_repository.dart';
import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flip_first_build/models/chat_contact_model.dart';
import 'package:flip_first_build/models/messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepo = ref.watch(chatRepoProvider);
  return ChatController(
    chatRepo: chatRepo,
    ref: ref,
  );
});

class ChatController {
  final ChatRepo chatRepo;
  final ProviderRef ref;

  ChatController({
    required this.chatRepo,
    required this.ref,
  });

  void userState(bool isOnline) {
    chatRepo.currentUserState(isOnline);
  }

  Stream<Box<ChatContactTile>> chatContacts() {
    return chatRepo.getChatContacts();
  }

  Stream<List<Messaging>> chatLog(String recieverUserId) {
    return chatRepo.getChatLog(recieverUserId);
  }

  void sentTextMessage(
    BuildContext context,
    String message,
    String recieverUserId,
  ) {
    ref.read(userProvider).whenData(
          (value) => chatRepo.sentMessage(
              context: context,
              message: message,
              recieverUserId: recieverUserId,
              senderUser: value!),
        );
  }

  void sentFile(
    BuildContext context,
    File file,
    String recieverUserId,
    ChatEnum chatEnum,
  ) {
    ref.read(userProvider).whenData((value) => chatRepo.sentFile(
        context: context,
        file: file,
        recieverUserId: recieverUserId,
        senderUserData: value!,
        ref: ref,
        chatEnum: chatEnum));
  }

  void messageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepo.messageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }
}
