import 'package:flip_first_build/chat_section/widgets/display_message.dart';
import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flutter/material.dart';
import '../../multi_use/colors.dart';

class MyMessages extends StatelessWidget {
  final String message;
  final String time;
  final ChatEnum type;
  final bool isSeen;
  const MyMessages({
    super.key,
    required this.message,
    required this.time,
    required this.type,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          color: secondColor,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Stack(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Padding(
                  padding: type == ChatEnum.message
                      ? const EdgeInsets.fromLTRB(
                          10,
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
                right: 0,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      isSeen ? Icons.done_all : Icons.done,
                      color: Colors.black,
                      size: 15,
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
