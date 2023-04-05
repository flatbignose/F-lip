import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../multi_use/colors.dart';

class ScreenLanding extends StatelessWidget {
  static const String routeName = '/landing-screen';
  const ScreenLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/landing_cover.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'F-lip!',
                  style: GoogleFonts.gorditas(color: secondColor, fontSize: 70),
                ),
                Text(
                  'Thank you for downloading',
                  style: GoogleFonts.gorditas(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'F-lip!',
                  style: GoogleFonts.gorditas(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'We hope that you stay long enough...',
                  style: GoogleFonts.gorditas(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => Navigator.pushNamed(context, '/login-screen'),
              child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: buttongradient,
                  ),
                  child: Center(
                    child: Text(
                      'Dive into the wormhole',
                      style: GoogleFonts.gorditas(
                        color: Colors.white,
                        fontSize: 17.5,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
