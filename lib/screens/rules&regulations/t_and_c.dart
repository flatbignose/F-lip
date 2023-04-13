import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multi_use/colors.dart';

class ScreenTandC extends StatelessWidget {
  const ScreenTandC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: ListView(
          children: [
            Text(
              'Terms & Conditions',
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
              'Welcome to F-lip!, a chat application made with Flutter and Firebase. By downloading, accessing, or using F-lip!, you agree to be bound by the following Terms and Conditions. If you do not agree with these terms, you must not use F-lip!.',
              style: GoogleFonts.gorditas(
                  fontSize: 20, fontWeight: FontWeight.bold, color: subColor),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              '1. Use Of F-lip!',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "F-lip! is intended for personal and non-commercial use only. You agree to use F-lip! solely for lawful purposes, and not to use F-lip! in any way that could damage, disable, overburden, or impair our servers or networks, or interfere with any other party's use and enjoyment of F-lip!. You must not attempt to gain unauthorized access to any part of F-lip!, the servers on which F-lip! is stored, or any server, computer or database connected to F-lip!.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '2. Privacy',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "We take your privacy very seriously. Please see our Privacy Policy for information on how we collect, use, and share your personal information.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '3. User Content',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "You retain all rights to any content you submit, upload, or transmit through F-lip!. The content exchanged between users through F-lip! is strictly personal and is intended only for the recipients of the communication. You grant us a limited license to use, store, and process the content solely for the purpose of providing the F-lip! service to you, and to comply with any applicable law or legal process. We will not disclose any user content to any third party, except as required by law or to comply with legal process. We will not use your user content for any other purpose, and we will not disclose it to any other user or third party without your express permission.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "You represent and warrant that: (i) you either are the sole and exclusive owner of all content or you have all rights, licenses, consents, and releases that are necessary to submit, upload, or transmit such content through F-lip!, as contemplated under these Terms and Conditions; and (ii) neither the content, nor your submission, uploading, publishing, or otherwise making available of such content, nor our use of the content as permitted herein will infringe, misappropriate or violate a third party's patent, copyright, trademark, trade secret, moral rights or other proprietary or intellectual property rights, or rights of publicity or privacy, or result in the violation of any applicable law or regulation.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '4. Intellectual property',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "F-lip! and all materials therein, including but not limited to software, images, text, graphics, logos, patents, trademarks, service marks, copyrights, photographs, audio, videos, and music, is owned by or licensed to us, and is subject to copyright and other intellectual property rights under United States and foreign laws and international conventions. F-lip! is licensed, not sold, to you.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            Text(
              '5. Termination',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "We reserve the right to terminate your access to F-lip! or to any portion thereof at any time, with or without notice. Upon termination, your right to use F-lip! will immediately cease.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            Text(
              '6. Disclaimer of warranties',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "F-lip! is a chat application intended for personal use. We make no guarantees or warranties of any kind, express or implied, regarding the reliability, availability, or suitability of the application for your particular purpose. You agree to use F-lip! at your own risk, and we shall not be held responsible for any loss or damage that may result from your use of the application.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
            Text(
              '7. Limitation of liability',
              style: GoogleFonts.gorditas(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondColor),
            ),
            Text(
              "We shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or relating to these Terms and Conditions or your use of F-lip!, including but not limited to any loss of data, loss of profits, or interruption of service. You agree that your use of F-lip! is at your own risk, and that we shall not be held liable for any damages that may result from your use of the application.",
              style: GoogleFonts.grandstander(fontSize: 16),
            ),
          ],
        ),
      )),
    );
  }
}
