import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/chat_section/screens/single_chat_room.dart';
import 'package:flip_first_build/models/chat_contact_model.dart';
import 'package:flip_first_build/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../multi_use/colors.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Box<ChatContactTile>>(
        stream: ref.watch(chatControllerProvider).chatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          final chatContactData = snapshot.data;
          List<ChatContactTile> chatDetails = chatContactData!.values.toList();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: chatDetails.length,
            itemBuilder: (context, index) {
              // ignore: prefer_const_constructors
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        Navigator.pushNamed(context, ScreenChatRoom.routeName,
                            arguments: {
                              'name': chatDetails[index].name,
                              'userId': chatDetails[index].contactId,
                              'profilePic': chatDetails[index].profilePic,
                            });
                      },
                      onTap: () {
                        Navigator.pushNamed(context, ScreenChatRoom.routeName,
                            arguments: {
                              'name': chatDetails[index].name,
                              'userId': chatDetails[index].contactId,
                              'profilePic': chatDetails[index].profilePic,
                            });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: secondColor,
                          child: CircleAvatar(
                            radius: 26,
                            backgroundImage:
                                NetworkImage(chatDetails[index].profilePic),
                          ),
                        ),
                        title: Text(chatDetails[index].name),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            chatDetails[index].lastMessage,
                            style: const TextStyle(color: subColor),
                          ),
                        ),
                        trailing: Text(DateFormat('hh:mm a')
                            .format(chatDetails[index].timeSent)),
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
