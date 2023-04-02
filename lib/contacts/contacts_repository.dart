import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/chat_section/screens/single_chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../multi_use/utils.dart';

final contactsRepoProvider =
    Provider((ref) => ContactsRepo(firestore: FirebaseFirestore.instance));

class ContactsRepo {
  final FirebaseFirestore firestore;

  ContactsRepo({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        // print(selectedPhNum);
        if (selectedPhNum == userData.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, ScreenChatRoom.routeName, arguments: {
            'name': userData.name,
            'userId': userData.userId,
            'profilePic': userData.profilePic,
          });
        }
      }
      if (!isFound) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, content: 'User Does not use F-lip');
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
