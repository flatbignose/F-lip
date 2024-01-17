import 'dart:io';
import 'package:flip_first_build/auth/repository/auth_repo.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo, ref: ref);
});

final userProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepo authRepo;
  final ProviderRef ref;
  AuthController({required this.authRepo, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepo.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepo.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepo.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserInfoToFirebase(
    BuildContext context,
    String name,
    String bio,
    File? profilePic,
  ) {
    authRepo.saveUserInfoToFirebase(
      name: name,
      bio: bio,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepo.userData(userId);
  }
}
