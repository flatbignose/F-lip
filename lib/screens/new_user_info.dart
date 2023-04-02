import 'dart:io';
import 'package:flip_first_build/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../multi_use/colors.dart';
import '../multi_use/utils.dart';

class ScreenNewUser extends ConsumerStatefulWidget {
  static const String routeName = '/new-user-info';
  const ScreenNewUser({super.key});

  @override
  ConsumerState<ScreenNewUser> createState() => _ScreenNewUserState();
}

class _ScreenNewUserState extends ConsumerState<ScreenNewUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File? image;
  //File? camImage;
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImageFromGallery() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserInfo() async {
    String name = nameController.text.trim();
    String bio = bioController.text.trim();

    if (name.isNotEmpty && bio.isNotEmpty) {
      ref.read(authControllerProvider).saveUserInfoToFirebase(
            context,
            name,
            bio,
            image,
          );
          }
        }

  // void selectImageFromCamera() async {
  //   camImage = await pickImageFromCamera(context);
  //   setState(() {});
  // }

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
                  fit: BoxFit.cover)),
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
                        ? const CircleAvatar(
                            radius: 97,
                            backgroundImage:
                                AssetImage('assets/images/default_user.png'),
                          )
                        : CircleAvatar(
                            radius: 97, backgroundImage: FileImage(image!)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        selectImageFromGallery();
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
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(98, 0, 0, 0),
                        filled: true,
                        hintText: 'Enter username',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: secondColor, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(98, 0, 0, 0),
                        filled: true,
                        hintText: 'Write something about you',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: secondColor, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    child: Expanded(
                      child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: buttongradient,
                          ),
                          child: Center(
                            child: Text(
                              'Enter new beginnings',
                              style: GoogleFonts.gorditas(
                                color: Colors.white,
                                fontSize: 16.5,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> selectPhoto(BuildContext ctx) async {
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (ctx1) => Container(
  //       height: 100,
  //       width: double.infinity,
  //       decoration: const BoxDecoration(
  //           color: subColor,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           )),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 InkWell(
  //                   onTap: () {
  //                     selectImageFromCamera();
  //                   },
  //                   child: const CircleAvatar(
  //                     radius: 30,
  //                     backgroundColor: secondColor,
  //                     child: Icon(
  //                       Icons.camera_alt,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     selectImageFromGallery();
  //                   },
  //                   child: const CircleAvatar(
  //                     backgroundColor: secondColor,
  //                     radius: 30,
  //                     child: Icon(
  //                       Icons.photo_size_select_actual_outlined,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: const [
  //                 Text(
  //                   'Camera',
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //                 SizedBox(
  //                   width: 20,
  //                 ),
  //                 Text(
  //                   'Gallery',
  //                   style: TextStyle(color: Colors.black),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
}
