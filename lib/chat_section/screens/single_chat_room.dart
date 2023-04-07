import 'package:flip_first_build/auth/controller/auth_controller.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/multi_use/colors.dart';
import 'package:flip_first_build/screens/flip_home.dart';
import 'package:flip_first_build/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/chat_input.dart';
import '../widgets/single_chat_view.dart';

class ScreenChatRoom extends ConsumerWidget {
  static const String routeName = '/single-chat-room';
  final String name;
  final String userId;
  final String profilePic;
  const ScreenChatRoom({
    super.key,
    required this.name,
    required this.userId,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilePic),
            ),
          ),
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDataById(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                }
                return Column(
                  children: [
                    Text(name),
                    Text(
                      snapshot.data!.isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(
                          color: subColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                );
              }),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                )),
          ],
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
                child: SingleChatView(
              recieverUserId: userId,
            )),
            ChatInput(
              recieverUserId: userId,
            ),
          ],
        ),
      ),
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenFlipHome(),
            ),
            (route) => false);
        return true;
      },
    );
  }
}
