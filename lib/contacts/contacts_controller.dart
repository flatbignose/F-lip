import 'package:flip_first_build/contacts/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactsProvider = FutureProvider((ref) {
  final contactRepo = ref.watch(contactsRepoProvider);
  return contactRepo.getContacts();
});

final contactsRepoControllerProvider = Provider((ref) {
  final contactsRepo = ref.watch(contactsRepoProvider);
  return SelectContactController(
    ref: ref,
    contactsRepo: contactsRepo,
  );
});

class SelectContactController {
  final ProviderRef ref;
  final ContactsRepo contactsRepo;

  SelectContactController({required this.ref, required this.contactsRepo});
  void selectContact(Contact selectedContact, BuildContext context) {
    contactsRepo.selectContact(selectedContact, context);
  }
}
