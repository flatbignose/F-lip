import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/contacts/contacts_generator.dart';
import 'package:flip_first_build/screens/user_info.dart';
import 'package:flip_first_build/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
    userDp();
    WidgetsBinding.instance.addObserver(this);
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

  //String profilePic = '';
  String ph = '';
  int _index = 0;
  final screens = [
    const ChatList(),
    const ScreenContacts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          'Flip!',
          style: GoogleFonts.gorditas(color: secondColor, fontSize: 40),
        ),
        actions: [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp)),
          // ignore: prefer_const_constructors
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              ScreenUserInfo.routeName,
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: secondColor,
              // ignore: prefer_const_constructors
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(ph),
              ),
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
        children: [Expanded(child: screens[_index])],
      ),
    );
  }

  void userDp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    setState(() {
      ph = data['profilePic'];
    });

    // setState(() {
    //   userData = data;
    // });
  }
}
