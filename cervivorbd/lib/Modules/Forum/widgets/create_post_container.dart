import 'package:cervivorbd/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children:  [
              // ProfileAvatar(imageUrl: currentUser.imageUrl),
              const SizedBox(width: 8.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'What\'s on your mind?',
                  ),
                ),
              ),
              ElevatedButton2(onPressed: (){},label:'Post'),
            ],
          ),
          const Divider(height: 10.0, thickness: 0.5),
        ],
      ),
    );
  }
}
