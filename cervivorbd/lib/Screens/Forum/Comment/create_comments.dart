import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:intl/intl.dart';

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
      setState(() {
        // call setState to rebuild the view
        loggedInUser = UserModel.fromMap(value.data());
      });
    });
  }

  buildComments() {
    final DateFormat formatter = DateFormat('hh:mm, dd-MM-yyyy');
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
                      timestamp: formatter
                          .format(DateTime.parse(document['timestamp'])),
                    );
                  },
                );
        });
  }

  addComment() async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc('all')
        .collection('userposts')
        .doc(postid)
        .update({'comments': FieldValue.increment(1)});
    FirebaseFirestore.instance
        .collection("posts")
        .doc(user!.email)
        .collection('userposts')
        .doc(postid)
        .update({'comments': FieldValue.increment(1)});
    await FirebaseFirestore.instance
        .collection("comments")
        .doc(postid)
        .collection("usercomments")
        .add({
      "postid": postid,
      "username": loggedInUser.fullname,
      "comment": commentController.text,
      "timestamp": DateTime.now(),
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
                controller: commentController,
                label: 'আপনার মন্তব্য প্রকাশ করুন..'),
            trailing: ElevatedButton2(
                onPressed: () => addComment(),
                icon: Icons.post_add_outlined,
                label: 'কমেন্ট'))
      ],
    ));
  }
}
