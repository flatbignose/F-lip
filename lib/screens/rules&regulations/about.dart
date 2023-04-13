import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multi_use/colors.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Text(
                'About Us',
                style: GoogleFonts.gorditas(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: secondColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "F-lip! is a mobile application that allows users to connect with their friends and family members and chat with them online. Our app provides a simple and easy-to-use interface that allows users to send text messages and photos to their contacts.\nWe are dedicated to making communication more accessible and convenient for people worldwide. Our app is built using the Flutter framework, which enables us to provide a seamless and intuitive user experience. We also leverage the power of Firebase, a backend service, to ensure that our users' data is secure and reliable.\nOur team is composed of talented and experienced software developers, designers, and project managers who are passionate about building innovative solutions that help people stay connected. We work tirelessly to ensure that our app is always up-to-date and meets the changing needs of our users.\nAt F-lip!, we prioritize our users' privacy and security. We take great care to protect our users' personal information and ensure that it is not disclosed to unauthorized parties.\n,We are committed to providing our users with a high-quality, user-friendly, and secure online chat experience.",
                    style: GoogleFonts.grandstander(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
