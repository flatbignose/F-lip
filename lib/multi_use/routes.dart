import 'package:flip_first_build/contacts/contacts_generator.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/screens/landing_page.dart';
import 'package:flip_first_build/screens/new_user_info.dart';
import 'package:flip_first_build/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../auth/screens/login.dart';
import '../auth/screens/otp.dart';
import '../chat_section/screens/single_chat_room.dart';
import 'error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenLogin.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenLogin(),
      );
    case ScreenOTP.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ScreenOTP(
          verificationId: verificationId,
        ),
      );
    case ScreenNewUser.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenNewUser(),
      );
    case ScreenLanding.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenLanding(),
      );
    case ScreenContacts.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenContacts(),
      );
    case ScreenChatRoom.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final userId = arguments['userId'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => ScreenChatRoom(
          name: name,
          userId: userId,
          profilePic: profilePic,
        ),
      );
      case ScreenUserInfo.routeName:
      final userDb = settings.arguments as Box<UserModel>;
      return MaterialPageRoute(
        builder: (context) =>  ScreenUserInfo(
          userDb: userDb,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
