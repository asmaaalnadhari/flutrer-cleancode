import 'package:flutter/material.dart';
import 'package:untitled11/Core/app_theme.dart';
import '../../../Domain/Entities/Post.dart';
import '../../Pages/post_detail_page.dart';
//----------------------------------------------
class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({Key? key, required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text('${posts[index].id.toString()}.',style: appTheme.textTheme.displayLarge,),
          title: Text(
            posts[index].title,
            style: appTheme.textTheme.displayMedium,
          ),
          subtitle: Text(
            posts[index].body,
            style: appTheme.textTheme.displaySmall,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return PostDetailPage(post: posts[index]);
                },
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
