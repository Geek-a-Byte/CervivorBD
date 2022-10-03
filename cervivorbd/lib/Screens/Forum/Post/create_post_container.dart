import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class CreatePostContainer extends StatefulWidget {
  const CreatePostContainer({Key? key}) : super(key: key);

  @override
  State<CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
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
                      createPost();
                    },
                    label: 'Post'),
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
          ],
        ),
      ),
    );
  }

  Future<void> createPost() async {
    // print(dateUTC + ' ' + date_Time + ':00');
    Post postModel = Post();
    String postiddd;

    // writing all the values
    postModel.ownerid = loggedInUser.email;
    postModel.postid = postiddd = DateTime.now().toString() +
        loggedInUser.fullname! +
        loggedInUser.email!;
    postModel.fullname = loggedInUser.fullname;
    postModel.details = blogEditingController.text;
    postModel.timeAgo = DateTime.now();
    postModel.likes = {};
    postModel.comments = 0;

    await FirebaseFirestore.instance
        .collection("posts")
        .doc(user!.email)
        .collection("userposts")
        .doc(postiddd)
        .set(postModel.toMapPost());
    await FirebaseFirestore.instance
        .collection("posts")
        .doc('all')
        .collection('userposts')
        .doc(postiddd)
        .set(postModel.toMapPost());

    blogEditingController.clear();
    Fluttertoast.showToast(msg: "Post created successfully!");
  }
}
