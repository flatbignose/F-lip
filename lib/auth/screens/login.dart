import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multi_use/colors.dart';
import '../../multi_use/utils.dart';
import '../controller/auth_controller.dart';

class ScreenLogin extends ConsumerStatefulWidget {
  static const String routeName = '/login-screen';
  const ScreenLogin({super.key});

  @override
  ConsumerState<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends ConsumerState<ScreenLogin> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_cover.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'F-lip!',
                    style: GoogleFonts.gorditas(
                      color: secondColor,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Register yourself to the new era of communication',
                    style:
                        GoogleFonts.gorditas(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Enter your phone number below',
                      style: GoogleFonts.aBeeZee(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (country != null)
                        Text(
                          '+${country!.phoneCode}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(98, 0, 0, 0),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: secondColor, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: secondColor, width: 2)),
                            label: Text('Phone Number'),
                            labelStyle: TextStyle(color: Colors.amberAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: pickCountry,
                    child: const Text('Pick Country'),
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: sendPhoneNumber,
                child: Container(
                    width: size.width * 0.3,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: buttongradient,
                    ),
                    child: const Center(
                        child: Text(
                      'Sent OTP',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
