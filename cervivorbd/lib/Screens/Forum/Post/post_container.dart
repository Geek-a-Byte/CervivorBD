// ignore_for_file: no_logic_in_create_state

import 'package:cervivorbd/Screens/Forum/Comment/create_comments.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:intl/intl.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

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
                  _PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  Text(
                    post.details!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

class PostStats extends StatefulWidget {
  final Post post;
  const PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  State<PostStats> createState() =>
      _PostStatsState(post, getLikeCount(post.likes));
}

class _PostStatsState extends State<PostStats> {
  Post? post;
  int likeCount;
  _PostStatsState(this.post, this.likeCount);

  User? user;
  Patient loggedInUser = Patient();

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          loggedInUser = Patient.fromMap(value.data());
          // call setState to rebuild the view
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = loggedInUser.uid!;
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                // '${post.likes}',
                '$likeCount',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            TextButton3(
                label: '${post!.comments} Comments',
                onPressed: () {
                  showComments(
                    context,
                    postid: post!.postid,
                    ownerid: post!.ownerid,
                  );
                }),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: post!.likes![currentUserId] == true
                  ? const Icon(
                      Icons.thumb_up,
                      size: 22.0,
                      color: Colors.black,
                    )
                  : Icon(
                      MdiIcons.thumbUpOutline,
                      color: Colors.grey[600],
                      size: 22.0,
                    ),
              label: 'Like',
              onTap: handleLikeCount,
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 22.0,
              ),
              label: 'Comment',
              onTap: () => showComments(
                context,
                postid: post!.postid,
                ownerid: post!.ownerid,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void handleLikeCount() {
    String currentUserId = loggedInUser.uid!;
    bool _isLiked = post!.likes![currentUserId] == true;

    if (_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc('all')
          .collection('userposts')
          .doc(post!.postid)
          .update({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        _isLiked = false;
        post!.likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc('all')
          .collection('userposts')
          .doc(post!.postid)
          .update({'likes.$currentUserId': true});
      setState(() {
        likeCount += 1;
        _isLiked = true;
        post!.likes[currentUserId] = true;
      });
    }
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = post.timeAgo!;
    final DateFormat formatter = DateFormat('hh:mm, dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.fullname!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    // '${post.timeAgo}',
                    formatted,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ],
    );
  }
}

showComments(BuildContext context, {String? postid, ownerid}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(postid: postid, postOwnerid: ownerid);
  }));
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final GestureTapCallback? onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(
                  label,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
