import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flip_first_build/firebase/firebase_storage_repo.dart';
import 'package:flip_first_build/models/chat_contact_model.dart';
import 'package:flip_first_build/models/messaging.dart';
import 'package:flip_first_build/multi_use/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../models/user_model.dart';
import 'dart:io';

final chatRepoProvider = Provider((ref) => ChatRepo(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class ChatRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepo({
    required this.firestore,
    required this.auth,
  });

  String? get recieverId => null;

  void currentUserState(bool isOnline) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }

  Stream<Box<ChatContactTile>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async {
      final chatTileDb = await Hive.openBox<ChatContactTile>('chatTile');
      chatTileDb.clear();
      List<ChatContactTile> contacts = [];
      // Hive.openBox<ChatContactTile>('chatTile');
      // Hive.deleteBoxFromDisk('chatTile');

      for (var document in event.docs) {
        var chatContact = ChatContactTile.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        ChatContactTile chatContactTile = ChatContactTile(
          name: chatContact.name,
          profilePic: chatContact.profilePic,
          contactId: chatContact.contactId,
          timeSent: chatContact.timeSent,
          lastMessage: chatContact.lastMessage,
        );

        chatTileDb.add(chatContactTile);

        // contacts.add(ChatContactTile(
        //   name: user.name,
        //   profilePic: user.profilePic,
        //   contactId: chatContact.contactId,
        //   timeSent: chatContact.timeSent,
        //   lastMessage: chatContact.lastMessage,
        // ));
      }

      return chatTileDb;
    });
  }

  Stream<List<Messaging>> getChatLog(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Messaging> messages = [];
      for (var document in event.docs) {
        messages.add(Messaging.fromMap(document.data()));
      }
      return messages;
    });
  }

  //save the message to firestore and display both in sender and reciever tile
  void _saveToContactCollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String message,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    // user -> reciever userId -> chta -> current userId > set data
    var recieverChatContact = ChatContactTile(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.userId,
      timeSent: timeSent,
      lastMessage: message,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    // user -> current userId -> chta -> reciever userId > set data
    var senderChatContact = ChatContactTile(
      name: recieverUserData.name,
      profilePic: recieverUserData.profilePic,
      contactId: recieverUserData.userId,
      timeSent: timeSent,
      lastMessage: message,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveToMessageCollection({
    required String recieverUserId,
    required String message,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUsername,
    required ChatEnum chatType,
  }) async {
    final messages = Messaging(
      senderId: auth.currentUser!.uid,
      recieverId: recieverUserId,
      message: message,
      messageId: messageId,
      type: chatType,
      timeSent: timeSent,
      isSeen: false,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(messages.toMap());

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(messages.toMap());
  }

  void sentMessage({
    required BuildContext context,
    required String message,
    required String recieverUserId,
    required UserModel senderUser,
  }) async {
    //user > senderId > recieverId > message > messageId > storemessage
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;
      var userData =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userData.data()!);

      var messageId = const Uuid().v1();

      // user -> reciever userId -> chta -> current userId > set data
      _saveToContactCollection(
        senderUser,
        recieverUserData,
        message,
        timeSent,
        recieverUserId,
      );

      _saveToMessageCollection(
        recieverUserId: recieverUserId,
        messageId: messageId,
        timeSent: timeSent,
        chatType: ChatEnum.message,
        message: message,
        username: senderUser.name,
        receiverUsername: recieverUserData.name,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sentFile({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required ChatEnum chatEnum,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      String imageUrl =
          await ref.read(commonFirebaseStorageRepoProvider).storeFileToFirebase(
                'singlechat/${chatEnum.type}/${senderUserData.userId}/$recieverUserId/$messageId',
                file,
              );
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      String contactMsg;
      switch (chatEnum) {
        case ChatEnum.image:
          contactMsg = '📷 Photo';
          break;
        default:
          contactMsg = '📷 Photo';
      }
      _saveToContactCollection(
        senderUserData,
        recieverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
      );
      _saveToMessageCollection(
        recieverUserId: recieverUserId,
        message: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        receiverUsername: recieverUserData.name,
        chatType: chatEnum,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void messageSeen(
      BuildContext context, String recieverUserId, String messageId) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });

      await firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
