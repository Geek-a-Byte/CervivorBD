import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('$comment'),
          subtitle: Text(timeago.format(timestamp!)),
        )
      ],
    );
  }
}
