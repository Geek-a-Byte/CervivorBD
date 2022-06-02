import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;



class CommentContainer extends StatelessWidget {
  final String? username;
  final String? userId;
  final String? comment;
  final String? timestamp;

  const CommentContainer({
    this.username,
    this.userId,
    this.comment,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(username!),
                  const SizedBox(height: 4.0),
                  Text(timestamp.toString()),
                  const SizedBox(height: 4.0),
                  Text(comment!),
                  // post.imageUrl != ''
                  //     ? const SizedBox.shrink()
                  //     : const SizedBox(height: 6.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
