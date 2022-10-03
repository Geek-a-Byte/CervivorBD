import 'package:cervivorbd/Screens/Forum/Comment/comment.dart';
import 'package:cervivorbd/Screens/UserProfiles/Patient/patient.dart';
import 'package:cervivorbd/Utils/Widgets/Buttons/elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateCommentContainer extends StatefulWidget {
  const CreateCommentContainer({Key? key}) : super(key: key);

  @override
  State<CreateCommentContainer> createState() => _CreateCommentContainerState();
}

class _CreateCommentContainerState extends State<CreateCommentContainer> {
  TextEditingController blogEditingController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                // ProfileAvatar(imageUrl: currentUser.imageUrl),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                    ),
                    controller: blogEditingController,
                  ),
                ),
                ElevatedButton2(
                    onPressed: () {
                      createComment();
                    },
                    label: 'Comment'),
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
          ],
        ),
      ),
    );
  }

  Future<void> createComment() async {
    // print(dateUTC + ' ' + date_Time + ':00');
    Comment commentModel = Comment();
    // writing all the values
    commentModel.commentid = loggedInUser.email;
    commentModel.fullname = loggedInUser.fullname;
    commentModel.details = blogEditingController.text;
    commentModel.timeAgo = DateTime.now();
    commentModel.likes = 0;

    await FirebaseFirestore.instance
        .collection("comments")
        .doc(user!.email)
        .collection("usercomments")
        .doc()
        .set(commentModel.toMapComment());
    await FirebaseFirestore.instance
        .collection("comments")
        .doc('all')
        .collection('usercomments')
        .doc()
        .set(commentModel.toMapComment());
    Fluttertoast.showToast(msg: "Comment created successfully!");
  }
}


// ExpansionTile(
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text(
//                                   document['doctor'],
//                                   style: GoogleFonts.lato(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 _compareDate(
//                                         document['date'].toDate().toString())
//                                     ? "TODAY"
//                                     : "",
//                                 style: GoogleFonts.lato(
//                                     color: Colors.green,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(
//                                 width: 0,
//                               ),
//                             ],
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(left: 5),
//                             child: Text(
//                               _dateFormatter(
//                                   document['date'].toDate().toString()),
//                               style: GoogleFonts.lato(),
//                             ),
//                           ),
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 20, right: 10, left: 16),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Patient name: " + document['name'],
//                                         style: GoogleFonts.lato(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         "Time: " +
//                                             _timeFormatter(
//                                               document['date']
//                                                   .toDate()
//                                                   .toString(),
//                                             ),
//                                         style: GoogleFonts.lato(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     tooltip: 'Delete Appointment',
//                                     icon: const Icon(
//                                       Icons.delete,
//                                       color: Colors.black87,
//                                     ),
//                                     onPressed: () {
//                                       print(">>>>>>>>>" + document.id);
//                                       _documentID = document.id;
//                                       showAlertDialog(context);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),