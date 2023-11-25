import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/Features/Post/presentation/Pages/post_add_update_page.dart';
import 'package:untitled11/Features/Post/presentation/bloc/post/post_bloc.dart';
import '../../../../Core/app_theme.dart';
import '../../../../Core/widgets/loading_widget.dart';
import '../Widgets/posts_page/message_display_widget.dart';
import '../Widgets/posts_page/post_list_widget.dart';
//====================================================================================
class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
//Main Methods:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  ///01#First comp:
  AppBar _buildAppbar() => AppBar(title:  Text('Posts',style: appTheme.textTheme.displayLarge,));

  ///02#Second comp:
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          ///LoadingPostsState:
          if (state is LoadingPostsState)
          {
            return const LoadingWidget();
          }
          ///LoadedPostsState:
          else if (state is LoadedPostsState)
          {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.posts));
          }
          ///ErrorPostsState:
          else if (state is ErrorPostsState)
          {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
  ///03#Third comp:
 _onRefresh(BuildContext context)  {
    BlocProvider.of<PostBloc>(context).add(RefreshPostsEvent());
  }
  ///04#Fourth comp:
  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(
                  isUpdatePost: false,
                )));
      },
      child: const Icon(Icons.add),
    );
  }
}