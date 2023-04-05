import 'package:flip_first_build/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ScreenOTP extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const ScreenOTP({super.key, required this.verificationId});

  void verifyOTP(BuildContext context, WidgetRef ref, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_cover.png'),
                  fit: BoxFit.cover)),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Enter OTP sent to your phone number',
                  style: GoogleFonts.grandstander(fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOTP(context, ref, value.trim());
                  }
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                length: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Phone Number?',
                    style: GoogleFonts.grandstander(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
