import 'package:flutter/material.dart';
import 'package:untitled11/Core/app_theme.dart';

import '../../../Domain/Entities/Post.dart';
import '../../Pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          side:const BorderSide(
            color: secondaryColor,
            width: 2,
          )
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdatePost: true,
                post: post,
              ),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
