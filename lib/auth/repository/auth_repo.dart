import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/auth/screens/otp.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/screens/flip_home.dart';
import 'package:flip_first_build/screens/new_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../firebase/firebase_storage_repo.dart';
import '../../multi_use/utils.dart';

final authRepoProvider = Provider((ref) => AuthRepo(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
      final userDb = await Hive.openBox<UserModel>('user');
      UserModel userModel = UserModel(
        name: user.name,
        bio: user.bio,
        profilePic: user.profilePic,
        userId: user.userId,
        phoneNumber: user.phoneNumber,
        isOnline: user.isOnline,
      );
      //userDb.put(0, userModel);
      userDb.add(userModel);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.pushNamed(
              context,
              ScreenOTP.routeName,
              arguments: verificationId,
            );
          },
          timeout: const Duration(seconds: 50),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      //ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, ScreenNewUser.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserInfoToFirebase({
    required String name,
    required String bio,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;
      String photoUrl = 'assets/images/default_user.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepoProvider)
            .storeFileToFirebase(
              'profilepic/$userId',
              profilePic,
            );

        final user = UserModel(
          name: name,
          bio: bio,
          profilePic: photoUrl,
          userId: userId,
          phoneNumber: auth.currentUser!.phoneNumber!,
          isOnline: true,
          // groupId: [],
        );
        await firestore.collection('users').doc(userId).set(user.toMap());

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenFlipHome(),
            ),
            (route) => false);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(
              event.data()!,
            ));
  }
}
