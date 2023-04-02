import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/chat_section/screens/single_chat_room.dart';
import 'package:flip_first_build/models/chat_contact_model.dart';
import 'package:flip_first_build/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../multi_use/colors.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ChatContactTile>>(
        stream: ref.watch(chatControllerProvider).chatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var chatContactData = snapshot.data![index];
              // ignore: prefer_const_constructors
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ScreenChatRoom.routeName,
                            arguments: {
                              'name': chatContactData.name,
                              'userId': chatContactData.contactId,
                              'profilePic': chatContactData.profilePic,
                            });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: secondColor,
                          child: CircleAvatar(
                              radius: 26,
                              backgroundImage:
                                  NetworkImage(chatContactData.profilePic)),
                        ),
                        title: Text(chatContactData.name),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            chatContactData.lastMessage,
                            style: const TextStyle(color: subColor),
                          ),
                        ),
                        trailing: Text(DateFormat('hh:mm a')
                            .format(chatContactData.timeSent)),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
