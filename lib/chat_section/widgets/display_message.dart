import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_first_build/enums/chat_enum.dart';
import 'package:flutter/material.dart';

class DisplayMessage extends StatelessWidget {
  final String message;
  final ChatEnum type;
  const DisplayMessage({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == ChatEnum.message
        ? Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.right,
          )
        : CachedNetworkImage(
            imageUrl: message,
          );
  }
}
