import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flutter/material.dart';
import '../../multi_use/colors.dart';
import 'display_message.dart';

class RecievedMessages extends StatelessWidget {
  final String message;
  final String time;
  final ChatEnum type;
  const RecievedMessages(
      {super.key,
      required this.message,
      required this.time,
      required this.type});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: subColor,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Stack(
            children: [
              Padding(
                  padding: type == ChatEnum.message
                      ? const EdgeInsets.fromLTRB(
                          50,
                          5,
                          30,
                          20,
                        )
                      : const EdgeInsets.fromLTRB(
                          5,
                          5,
                          5,
                          25,
                        ),
                  child: DisplayMessage(
                    message: message,
                    type: type,
                  )),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
