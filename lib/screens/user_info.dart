import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user_model.dart';

class ScreenUserInfo extends StatefulWidget {
  static const String routeName = '/user-info';
  final Box<UserModel> userDb;
  const ScreenUserInfo({super.key, required this.userDb});

  @override
  State<ScreenUserInfo> createState() => _ScreenUserInfoState();
}

class _ScreenUserInfoState extends State<ScreenUserInfo> {
  @override
  void initState() {
    // TODO: implement initState
    //userInfo();
    super.initState();
  }

  // String profilePic = '';
  // String name = '';
  // String bio = '';
  // String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: secondColor,
      //   elevation: 0,
      //   child: const Icon(Icons.edit),
      // ),
      backgroundColor: const Color.fromRGBO(30, 24, 9, 1),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      color: Colors.white70,
                      width: size.width,
                      height: size.height / 2,
                      child: Image.network(
                        widget.userDb.values.last.profilePic,
                        fit: BoxFit.fitHeight,
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black26,
                              Colors.transparent,
                            ])),
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        width: size.width,
                        height: size.height / 20,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                          ),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      color: Colors.black54,
                      height: size.height / 16,
                      child: Text(
                        widget.userDb.values.last.name,
                        style: GoogleFonts.grandstander(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(83, 68, 30, 0.6),
                  ),
                  width: size.width,
                  height: size.height * 0.15,
                  child: Text('“${widget.userDb.values.last.bio}”',
                      style: GoogleFonts.grandstander(fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  color: const Color.fromRGBO(83, 68, 30, 0.6),
                  width: size.width,
                  height: size.height / 15,
                  child: Text(widget.userDb.values.last.phoneNumber,
                      style: GoogleFonts.grandstander(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void userInfo() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final info =
  //       await firestore.collection('users').doc(auth.currentUser!.uid).get();
  //   setState(() {
  //     profilePic = info['profilePic'];
  //     name = info['name'];
  //     bio = info['bio'];
  //     phoneNumber = info['phoneNumber'];
  //   });

  // }
}
