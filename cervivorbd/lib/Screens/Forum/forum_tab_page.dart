import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Posts Appears here...',
                          style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
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
