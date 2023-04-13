import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/contacts/contacts_generator.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/screens/search_page.dart';
import 'package:flip_first_build/screens/user_info.dart';
import 'package:flip_first_build/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../multi_use/colors.dart';

class ScreenFlipHome extends ConsumerStatefulWidget {
  const ScreenFlipHome({super.key});
  @override
  ConsumerState<ScreenFlipHome> createState() => _ScreenFlipHomeState();
}

//code refraction required for profilePic!!!
class _ScreenFlipHomeState extends ConsumerState<ScreenFlipHome>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(chatControllerProvider).userState(true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        ref.read(chatControllerProvider).userState(false);
        break;
      default:
    }
  }

  int _index = 0;
  final screens = [
    ChatList(),
    const ScreenContacts(),
  ];
  Box<UserModel>? user;
  bool searchPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          'F-lip!',
          style: GoogleFonts.gorditas(color: secondColor, fontSize: 40),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  searchPressed = !searchPressed;
                });
              },
              icon: const Icon(Icons.search_sharp)),
          // ignore: prefer_const_constructors
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, ScreenUserInfo.routeName,
                arguments: user),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: secondColor,
              // ignore: prefer_const_constructors
              child: FutureBuilder(
                  future: Hive.openBox<UserModel>('user'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final userDb = Hive.box<UserModel>('user');
                      user = userDb;
                      return CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage(userDb.values.last.profilePic),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          )
        ],
        elevation: 0,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastOutSlowIn,
        height: 50,
        items: const <Widget>[
          Icon(Icons.message, size: 25, color: secondColor),
          Icon(Icons.import_contacts_rounded, size: 25, color: secondColor),
          // Icon(Icons.person, size: 30, color: secondColor),
        ],
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        color: Colors.black,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body:
          //const ChatList(),
          Column(
        children: [
          Visibility(
            visible: searchPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search User',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) {
                      // widget.searchaeererer.search(user!, value);\
                      DisplaySearch.search(user!, value);
                    },
                  ),
                ),
              ),
            ),
          ),
          searchPressed
              ? Expanded(child: DisplaySearch())
              : Expanded(child: screens[_index])
        ],
      ),
    );
  }

//   //static ValueNotifier<List<UserModel>> searchResult = ValueNotifier([]);

  //   //
}
