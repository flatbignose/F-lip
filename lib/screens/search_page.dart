import 'package:flip_first_build/models/chat_contact_model.dart';
import 'package:flip_first_build/multi_use/colors.dart';
import 'package:flip_first_build/screens/flip_home.dart';
import 'package:flip_first_build/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../chat_section/screens/single_chat_room.dart';
import '../models/user_model.dart';

Map<int, ChatContactTile> searchList = {};
List<ChatContactTile> userList = [];

class DisplaySearch extends StatelessWidget {
  DisplaySearch({super.key});

  // final Box<UserModel> user;
  static ValueNotifier<Map<int, ChatContactTile>> searchListNotifier =
      ValueNotifier({});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<int, ChatContactTile>>(
      valueListenable: searchListNotifier,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Navigator.pushReplacementNamed(context, Scree, arguments: {
                //   'name': userList[index].name,
                //   'userId': userList[index].contactId,
                //   'profilePic': userList[index].profilePic,
                // });
                Navigator.pushNamed(context, ScreenChatRoom.routeName,
                    arguments: {
                      'name': userList[index].name,
                      'userId': userList[index].contactId,
                      'profilePic': userList[index].profilePic,
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: secondColor,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(userList[index].profilePic),
                    ),
                  ),
                  title: Text(
                    userList[index].name,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      userList[index].lastMessage,
                      maxLines: 1,
                      style: const TextStyle(color: subColor),
                    ),
                  ),
                  trailing: Text(
                    DateFormat('hh:mm a').format(userList[index].timeSent),
                    style: const TextStyle(fontSize: 12, color: subColor),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    //  ListView.builder(
    //   itemBuilder: (context, index) {

    //   },
    //   itemCount: user.length,
    // );
  }

  static search(Box<UserModel> user, String values) {
    Map<dynamic, ChatContactTile> chatTileDb =
        Hive.box<ChatContactTile>('chatTile').toMap();
    searchList.clear();
    userList.clear();
    chatTileDb.forEach((key, value) {
      if (value.name.toLowerCase().contains(values.toLowerCase())) {
        searchList[key] = value;
      }
    });
    searchListNotifier.value.clear();
    userList = searchList.values.toList();
    searchListNotifier.value.addAll(searchList);
    searchListNotifier.notifyListeners();
  }
}
