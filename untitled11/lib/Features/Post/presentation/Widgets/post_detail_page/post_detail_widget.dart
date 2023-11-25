import 'package:flutter/material.dart';
import 'package:untitled11/Features/Post/presentation/Widgets/post_detail_page/update_post_btn_widget.dart';
import '../../../../../Core/app_theme.dart';
import '../../../Domain/Entities/Post.dart';
import 'delete_post_btn_widget.dart';
class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              post.title,
              style: appTheme.textTheme.displayMedium,
            ),
            const Divider(
              thickness: 4,
              height: 30,
            ),
            Text(
              post.body,
              style: appTheme.textTheme.displaySmall,
            ),
            const Divider(
              thickness: 4,
              height: 30,
        
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpdatePostBtnWidget(post: post),
                DeletePostBtnWidget(postId: post.id!)
              ],
            )
          ],
        ),
      ),
    );
  }
}

