import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flip_first_build/multi_use/colors.dart';
import 'package:flip_first_build/multi_use/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatInput extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatInput({required this.recieverUserId, super.key});

  @override
  ConsumerState<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends ConsumerState<ChatInput> {
  final TextEditingController _messagecontroller = TextEditingController();
  bool isTyping = false;
  // bool isEmojiSet = false;
  //FocusNode focusNode = FocusNode();

  void sentMessage() async {
    if (isTyping) {
      ref.read(chatControllerProvider).sentTextMessage(
            context,
            _messagecontroller.text.trim(),
            widget.recieverUserId,
          );
      setState(() {
        _messagecontroller.text = '';
      });
    }
  }

  // void hideEmojiSet() {
  //   setState(() {
  //     isEmojiSet = false;
  //   });
  // }

  // void showEmojiSet() {
  //   setState(() {
  //     isEmojiSet = true;
  //   });
  // }

  // void showKeyboard() => focusNode.requestFocus();
  // void hideKeyboard() => focusNode.unfocus();

  // void switchEmojiKeyboard() {
  //   if (isEmojiSet) {
  //     showKeyboard();
  //     hideEmojiSet();
  //   } else {
  //     hideKeyboard();
  //     showEmojiSet();
  //   }
  // }

  void sentFile(
    File file,
    ChatEnum chatEnum,
  ) async {
    ref
        .read(chatControllerProvider)
        .sentFile(context, file, widget.recieverUserId, chatEnum);
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sentFile(image, ChatEnum.image);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // IconButton(
                //     splashRadius: 10,
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.emoji_emotions_outlined,
                //       color: subColor,
                //     )),
                Expanded(
                    child: TextFormField(
                  // focusNode: focusNode,
                  controller: _messagecontroller,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isTyping = true;
                      });
                    } else {
                      setState(() {
                        isTyping = false;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Message',
                    border: InputBorder.none,
                  ),
                )),
                IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.photo_size_select_actual_outlined,
                      color: subColor,
                    )),
                IconButton(
                  onPressed: () {
                    
                    sentMessage();
                  },
                  icon: isTyping
                      ? const Icon(
                          Icons.send,
                          color: subColor,
                        )
                      : Icon(
                          Icons.mic,
                          color: subColor,
                        ),
                ),
              ],
            ),
            // isEmojiSet
            //     ? SizedBox(
            //         height: 350,
            //         child: EmojiPicker(
            //           onEmojiSelected: (category, emoji) {
            //             setState(() {
            //               _messagecontroller.text =
            //                   _messagecontroller.text + emoji.emoji;
            //             });
            //           },
            //         ),
            //       )
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
