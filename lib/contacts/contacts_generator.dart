import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/contacts/contacts_controller.dart';
import 'package:flip_first_build/screens/splash_screen.dart';
import 'package:flip_first_build/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../multi_use/error.dart';

class ScreenContacts extends ConsumerWidget {
  static const String routeName = '/contacts-screen';
  const ScreenContacts({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(contactsRepoControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Contacts'),
      //   actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      // ),
      body: ref.watch(getContactsProvider).when(
            data: (contactsList) => ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                final contact = contactsList[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => selectContact(ref, contact, context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: contact.photo == null
                              ? CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/default_user.png'),
                                  radius: 30,
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                          title: Text(contact.displayName),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                );
              },
            ),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loading(),
          ),
    );
  }

  Future<List> getUsers() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> users =
        await firestore.collection('users').get();
    List userList = [];
    for (var element in users.docs) {
      Map<String, dynamic> uservalues = element.data();
      userList.add(uservalues['phoneNumber']);
    }
    return userList;
  }
}
