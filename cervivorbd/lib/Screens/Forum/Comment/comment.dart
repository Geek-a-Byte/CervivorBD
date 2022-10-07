import 'package:cervivorbd/Utils/Exports/firebase.dart';

class Comment {
  final String? username;
  final String? userId;
  final String? comment;
  final DateTime? timestamp;

  const Comment({this.username, this.userId, this.comment, this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
        username: doc['username'],
        userId: doc['userId'],
        comment: doc['comment'],
        timestamp: doc['timestamp']);
  }
}

