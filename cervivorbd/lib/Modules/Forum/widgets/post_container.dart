import 'package:cervivorbd/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                  Text(post.details!),
                  // post.imageUrl != ''
                  //     ? const SizedBox.shrink()
                  //     : const SizedBox(height: 6.0),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              // child: NetworkImage('${post.imageUrl}'),
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

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ProfileAvatar(imageUrl: post.user.imageUrl),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.fullname!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    '${post.timeAgo}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 9.0,
                    ),
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
  Post post;
  int likeCount;
  _PostStatsState(this.post, this.likeCount);

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
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: handleLikeCount,
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  void handleLikeCount() {

    String currentUserId = loggedInUser.uid!;
    bool _isLiked = post.likes![currentUserId] == true;

    if (_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc('all')
          .collection('userposts')
          .doc(post.postid)
          .update({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        _isLiked = false;
         post.likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc('all')
          .collection('userposts')
          .doc(post.postid)
          .update({'likes.$currentUserId': true});
      setState(() {
        likeCount += 1;
        _isLiked = true;
        post.likes[currentUserId] = true;
      });
    }
  }
}

// class _PostStats extends StatelessWidget {
//   final Post post;

//   final String text = '';
//   final bool shouldDisplay = false;

//   const _PostStats({
//     Key? key,
//     required this.post,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(4.0),
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.thumb_up,
//                 size: 10.0,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(width: 4.0),
//             Expanded(
//               child: Text(
//                 '${post.likes}',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ),
//             Text(
//               '${post.comments} Comments',
//               style: TextStyle(
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         const Divider(),
//         Row(
//           children: [
//             _PostButton(
//               icon: Icon(
//                 MdiIcons.thumbUpOutline,
//                 color: Colors.grey[600],
//                 size: 20.0,
//               ),
//               label: 'Like',
//               onTap: () {},
//             ),
//             _PostButton(
//               icon: Icon(
//                 MdiIcons.commentOutline,
//                 color: Colors.grey[600],
//                 size: 20.0,
//               ),
//               label: 'Comment',
//               onTap: () {

//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

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
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
