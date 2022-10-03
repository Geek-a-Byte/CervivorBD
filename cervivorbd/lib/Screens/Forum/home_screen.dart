import 'package:cervivorbd/Screens/Forum/Post/create_post_container.dart';
import 'package:cervivorbd/Screens/Forum/Post/post.dart';
import 'package:cervivorbd/Screens/Forum/Post/post_container.dart';
import 'package:cervivorbd/Screens/UserProfiles/Patient/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ForumTabPage extends StatefulWidget {
  const ForumTabPage({Key? key}) : super(key: key);

  @override
  State<ForumTabPage> createState() => _ForumTabPageState();
}

class _ForumTabPageState extends State<ForumTabPage> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const CreatePostContainer(),
          SafeArea(
            child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc('all')
                .collection('userposts')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data!.size == 0
                  ? Center(
                      child: Text(
                        'Posts Appears here...',
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
                        final Post post = Post(
                          postid: document['postid'],
                          fullname: document['fullname'],
                          details: document['details'],
                          timeAgo: document['timeAgo'].toDate(),
                          likes: document['likes'],
                          comments: document['comments'],
                        );
                        return PostContainer(post: post);
                      },
                    );
            },
          )),
        ],
      ),
    );
  }
}
// class ForumTabPage extends StatelessWidget {
//   const ForumTabPage({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       CreatePostContainer(),
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('posts')
//             .doc(user!.email.toString())
//             .collection('userposts')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return snapshot.data!.size == 0
//               ? Center(
//                   child: Text(
//                     'History Appears here...',
//                     style: GoogleFonts.lato(
//                       color: Colors.grey,
//                       fontSize: 18,
//                     ),
//                   ),
//                 )
//               : ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   physics: const ClampingScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.size,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot document = snapshot.data!.docs[index];
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.only(left: 10, top: 5),
//                           height: 50,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.blueGrey[50],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 document['doctor'],
//                                 style: GoogleFonts.lato(
//                                     fontSize: 15, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 _dateFormatter(
//                                     document['date'].toDate().toString()),
//                                 style: GoogleFonts.lato(
//                                     fontSize: 12, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     );
//                   },
//                 );
//         },
//       ),
//     );
//   }
// }
