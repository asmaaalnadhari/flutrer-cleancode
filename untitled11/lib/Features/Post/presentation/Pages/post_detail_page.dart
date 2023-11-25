import 'package:flutter/material.dart';
import '../../../../Core/app_theme.dart';
import '../../Domain/Entities/Post.dart';
import '../Widgets/post_detail_page/post_detail_widget.dart';
//====================================================================================
class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  //Main Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  ///01#First Component:
  AppBar _buildAppbar() {return AppBar(title:  Text("Post Detail",style: appTheme.textTheme.displayLarge),);}

  ///02#Second Component:
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailWidget(post: post),
    );
  }
}
