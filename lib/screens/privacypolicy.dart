import 'package:flip_first_build/multi_use/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

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
                'Privacy Policy',
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
              Text(
                'Collection of Information',
                style: GoogleFonts.gorditas(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondColor),
              ),
              Text(
                "We may collect certain personal information from you when you use our mobile application. This information may include your name, email address, phone number, and any other information you provide to us when you create an account or use our services.\nWe may also collect non-personal information such as your device information, location data, and usage patterns to improve our application's performance and user experience.",
                style: GoogleFonts.grandstander(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Use of Information',
                style: GoogleFonts.gorditas(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondColor),
              ),
              Text(
                "We use your personal information to provide our services to you, communicate with you, and improve our application. We may also use your information to send you promotional materials or other communications that we think may be of interest to you.\nWe do not sell or rent your personal information to third parties. We may share your information with our service providers or other third-party partners who assist us in providing our services to you.",
                style: GoogleFonts.grandstander(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Security',
                style: GoogleFonts.gorditas(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondColor),
              ),
              Text(
                "We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. We use industry-standard security measures to safeguard your information.\nHowever, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee the absolute security of your information.",
                style: GoogleFonts.grandstander(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Changes to the Privacy Policy',
                style: GoogleFonts.gorditas(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondColor),
              ),
              Text(
                "We reserve the right to modify this privacy policy at any time. Any changes to this policy will be posted on our mobile application, and we encourage you to review this policy periodically.",
                style: GoogleFonts.grandstander(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Contact Us',
                style: GoogleFonts.gorditas(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: secondColor),
              ),
              Text(
                "If you have any questions about this privacy policy, please contact us at saleemsahil591@gmail.com",
                style: GoogleFonts.grandstander(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
