import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/auth/screens/login.dart';
import 'package:flip_first_build/screens/edit_user_info.dart';
import 'package:flip_first_build/screens/rules&regulations/about.dart';
import 'package:flip_first_build/screens/rules&regulations/privacypolicy.dart';
import 'package:flip_first_build/screens/rules&regulations/t_and_c.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../multi_use/colors.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenEditUser(
                  user: widget.userDb,
                ),
              ));
        },
        backgroundColor: secondColor,
        elevation: 0,
        child: const Icon(Icons.edit),
      ),
      backgroundColor: const Color.fromRGBO(30, 24, 9, 1),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
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
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(83, 68, 30, 0.6),
                  width: size.width,
                  height: size.height / 15,
                  child: Text(
                    widget.userDb.values.last.phoneNumber,
                    style: GoogleFonts.grandstander(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenAboutUs(),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    color: const Color.fromRGBO(83, 68, 30, 0.6),
                    width: size.width,
                    height: size.height / 15,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('About Us',
                            style: GoogleFonts.grandstander(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenPrivacyPolicy(),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    color: const Color.fromRGBO(83, 68, 30, 0.6),
                    width: size.width,
                    height: size.height / 15,
                    child: Row(
                      children: [
                        const Icon(Icons.privacy_tip_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Privacy Policy',
                            style: GoogleFonts.grandstander(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenTandC(),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    color: const Color.fromRGBO(83, 68, 30, 0.6),
                    width: size.width,
                    height: size.height / 15,
                    child: Row(
                      children: [
                        const Icon(Icons.privacy_tip_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Terms & Conditions',
                            style: GoogleFonts.grandstander(fontSize: 20)),
                      ],
                    ),
                  ),
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
                  child: Row(
                    children: [
                      const Icon(Icons.featured_play_list_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Feedback',
                          style: GoogleFonts.grandstander(fontSize: 20)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: secondColor, width: 1)),
                          backgroundColor: Colors.black,
                          //   title: Text(''),
                          content: Text('Leaving Already?',
                              style: GoogleFonts.grandstander(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Not yet',
                                  style: TextStyle(color: secondColor),
                                )),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .whenComplete(() =>
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              ScreenLogin.routeName,
                                              (route) => false));
                                },
                                child: const Text(
                                  "I'm Done!",
                                  style: TextStyle(color: secondColor),
                                ))
                          ],
                        );
                      }));
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    color: const Color.fromRGBO(83, 68, 30, 0.6),
                    width: size.width,
                    height: size.height / 15,
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Logout',
                            style: GoogleFonts.grandstander(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
