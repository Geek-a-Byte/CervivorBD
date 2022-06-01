import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ForumTabPage extends StatelessWidget {
  const ForumTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: currentUser),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Post post = posts[index];
                  return PostContainer(post: post);
                },
                childCount: posts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
