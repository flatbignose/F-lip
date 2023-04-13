import 'dart:io';

import 'package:flip_first_build/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/controller/auth_controller.dart';
import '../multi_use/colors.dart';
import '../multi_use/utils.dart';

class ScreenEditUser extends ConsumerStatefulWidget {
  final Box<UserModel> user;
  const ScreenEditUser({required this.user, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenEditUserState();
}

class _ScreenEditUserState extends ConsumerState<ScreenEditUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.user.values.last.name);
    bioController = TextEditingController(text: widget.user.values.last.bio);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImageFromGallery(ImageSource source) async {
    image = await pickImageFromGallery(context, source);
    setState(() {
      pressed = true;
    });
  }

  void storeUserInfo() async {
    String name = nameController.text.trim();
    String bio = bioController.text.trim();

    if (name.isNotEmpty && bio.isNotEmpty && pressed) {
      ref.read(authControllerProvider).saveUserInfoToFirebase(
            context,
            name,
            bio,
            image,
          );
    }
  }

  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_cover.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: secondColor,
                      child: image == null
                          ? CircleAvatar(
                              radius: 97,
                              backgroundColor: Colors.green,
                              backgroundImage: NetworkImage(
                                  widget.user.values.last.profilePic),
                            )
                          : CircleAvatar(
                              radius: 97,
                              backgroundImage: FileImage(image!),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          selectPhoto(context);
                        },
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: secondColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 32,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color.fromARGB(255, 207, 199, 199),
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: nameController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(98, 0, 0, 0),
                          filled: true,
                          counterText: '',
                          hintText: 'Enter username',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: secondColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: secondColor, width: 2)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        controller: bioController,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(98, 0, 0, 0),
                          filled: true,
                          hintText: 'Update your bio',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: secondColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: secondColor, width: 2)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        storeUserInfo();
                      },
                      child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: buttongradient,
                          ),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.gorditas(
                                color: Colors.white,
                                fontSize: 16.5,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectPhoto(BuildContext ctx) async {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx1) => Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: subColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      selectImageFromGallery(ImageSource.camera);
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: secondColor,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      selectImageFromGallery(ImageSource.gallery);
                    },
                    child: const CircleAvatar(
                      backgroundColor: secondColor,
                      radius: 30,
                      child: Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Camera',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
