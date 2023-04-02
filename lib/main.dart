import 'package:firebase_core/firebase_core.dart';
import 'package:flip_first_build/screens/flip_home.dart';
import 'package:flip_first_build/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'auth/controller/auth_controller.dart';
import 'firebase/firebase_options.dart';
import 'multi_use/error.dart';
import 'multi_use/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
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
      home: ref.watch(userProvider).when(
            data: (user) {
              if (user == null) {
                return const ScreenSplash();
              }
              return const ScreenFlipHome();
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const ScreenSplash(),
          ),
    );
  }
}
