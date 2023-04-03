import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> fetchUserInfo() async {
  final userInfoDb = await Hive.openBox<UserModel>('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
