import 'package:cervivorbd/Screens/Forum/Comment/comment_container.dart';
import 'package:cervivorbd/Screens/UserProfiles/Patient/patient.dart';
import 'package:cervivorbd/Utils/Widgets/TextStyle/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String? postid;
  final String? postOwnerid;

  const Comments({Key? key, this.postid, this.postOwnerid}) : super(key: key);

  @override
  State<Comments> createState() =>
      _CommentsState(postid: postid, postOwnerid: postOwnerid);
}

class _CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String? postid;
  final String? postOwnerid;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  buildComments() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("comments")
            .doc(postid)
            .collection('usercomments')
            .orderBy("timestamp", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List<Comment> comments = [];
          // snapshot.data!.docs.map((doc) {
          //   comments.add((Comment.fromDocument(doc)));
          // });
          // return ListView(
          //   children: comments,
          // );
          return snapshot.data!.size == 0
              ? Center(
                  child: Text(
                    'Comments Appears here...',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return CommentContainer(
                      username: document['username'],
                      userId: document['userId'],
                      comment: document['comment'],
                      timestamp: document['timestamp'],
                    );
                  },
                );
        });
  }

  addComment() async {
    await FirebaseFirestore.instance
        .collection("comments")
        .doc(postid)
        .collection("usercomments")
        .add({
      "username": loggedInUser.fullname,
      "comment": commentController.text,
      "timestamp": DateTime.now().toString(),
      "userId": loggedInUser.uid
    });
    commentController.clear();
    Fluttertoast.showToast(msg: "comment created successfully!");
  }

  _CommentsState({this.postid, this.postOwnerid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: buildComments(),
        ),
        const Divider(),
        ListTile(
            title: TextFormField2(
                controller: commentController, label: 'Write a comment...'),
            trailing: ElevatedButton(
                onPressed: () => addComment(), child: const Text('Post')))
      ],
    ));
  }
}

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
