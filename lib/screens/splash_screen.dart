import 'package:flip_first_build/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../multi_use/colors.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    gotoLanding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/landing_cover.png'),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'F-lip!',
              style: GoogleFonts.gorditas(color: secondColor, fontSize: 70),
            ),
            Positioned(
              bottom: 180,
              child: Lottie.asset(
                  'assets/lottie_files/bright-loading-dots.json',
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 50),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoLanding() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenLanding(),
        ),
        (route) => false);
  }
}
