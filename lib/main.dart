import 'package:firebase_core/firebase_core.dart';
import 'package:flip_first_build/auth/screens/login.dart';
import 'package:flip_first_build/auth/screens/otp.dart';
import 'package:flip_first_build/models/user_model.dart';
import 'package:flip_first_build/screens/flip_home.dart';
import 'package:flip_first_build/screens/new_user_info.dart';
import 'package:flip_first_build/screens/screen_loader.dart';
import 'package:flip_first_build/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'auth/controller/auth_controller.dart';
import 'firebase/firebase_options.dart';
import 'models/chat_contact_model.dart';
import 'multi_use/error.dart';
import 'multi_use/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ChatContactTileAdapter().typeId)) {
    Hive.registerAdapter(ChatContactTileAdapter());
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(background: Colors.black)),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: 
      ref.watch(userProvider).when(
        data: (user) {
          if (user == null) {
            return const ScreenSplash();
          }
          return ScreenFlipHome();
        },
        error: (err, trace) {
          return ErrorScreen(error: err.toString());
        },
        loading: () => const ScreenLoader(),
      ),
    );
  }
}
