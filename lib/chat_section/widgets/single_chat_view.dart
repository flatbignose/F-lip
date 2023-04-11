import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_first_build/chat_section/controller/chat_controller.dart';
import 'package:flip_first_build/chat_section/widgets/recieved_messages.dart';
import 'package:flip_first_build/models/messaging.dart';
import 'package:flip_first_build/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'my_messages.dart';

class SingleChatView extends ConsumerStatefulWidget {
  final String recieverUserId;
  // final String messageId;
  const SingleChatView({
    Key? key,
    required this.recieverUserId,
    // required this.messageId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingleChatViewState();
}

class _SingleChatViewState extends ConsumerState<SingleChatView> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool isVisible = false;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<List<Messaging>>(
          stream:
              ref.read(chatControllerProvider).chatLog(widget.recieverUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              messageController
                  .jumpTo(messageController.position.maxScrollExtent);
            });
            DateTime? lastTime;
            return ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                final timesent =
                    DateFormat('hh:mm a').format(messageData.timeSent);

                final date =
                    DateFormat('E MMM d, yyyy').format(messageData.timeSent);

                if (!messageData.isSeen &&
                    messageData.recieverId ==
                        FirebaseAuth.instance.currentUser!.uid) {
                  ref.read(chatControllerProvider).messageSeen(
                      context, widget.recieverUserId, messageData.messageId);
                }
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  if (lastTime == null ||
                      lastTime!.difference(messageData.timeSent).inHours != 0) {
                    lastTime = messageData.timeSent;
                    return Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height * 0.02,
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                            )),
                        MyMessages(
                          message: messageData.message,
                          time: timesent,
                          type: messageData.type,
                          isSeen: messageData.isSeen,
                        ),
                      ],
                    );
                  } else {
                    return MyMessages(
                      message: messageData.message,
                      time: timesent,
                      type: messageData.type,
                      isSeen: messageData.isSeen,
                    );
                  }
                }
                if (lastTime == null ||
                    lastTime!.difference(messageData.timeSent).inDays != 0) {
                  lastTime = messageData.timeSent;
                  return Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height * 0.023,
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            date,
                            textAlign: TextAlign.center,
                          )),
                      RecievedMessages(
                        message: messageData.message,
                        time: timesent,
                        type: messageData.type,
                      ),
                    ],
                  );
                } else {
                  return RecievedMessages(
                    message: messageData.message,
                    time: timesent,
                    type: messageData.type,
                  );
                }
              },
            );
          }),
    );
  }
}
