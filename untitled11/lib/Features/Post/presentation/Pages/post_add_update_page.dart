import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/Features/Post/presentation/Pages/posts_page.dart';
import '../../../../Core/app_theme.dart';
import '../../../../Core/util/snackbar_message.dart';
import '../../../../Core/widgets/loading_widget.dart';
import '../../Domain/Entities/Post.dart';
import '../Widgets/post_add_update_page/form_widget.dart';
import '../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
//#######################################################################
class PostAddUpdatePage extends StatelessWidget {
  //-----------------------------
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({
    Key? key,
    this.post,
    required this.isUpdatePost,
    }): super(key: key);
  //-----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }
  //01#:
  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post",style: appTheme.textTheme.displayLarge));
  }
  //02#:
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 15),
            child:
            BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
              ///01#:First Function:
              listener: (context, state) {
                ///MessageAddDeleteUpdatePostState:
                if (state is MessageAddDeleteUpdatePostState)
                {
                  SnackBarMessage().showSuccessSnackBar
                    (
                      message: state.message,
                      context: context
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const PostsPage()),
                          (route) => false);
                }
                ///ErrorAddDeleteUpdatePostState:
                else if (state is ErrorAddDeleteUpdatePostState) {
                  SnackBarMessage().showErrorSnackBar
                          (
                      message: state.message,
                      context: context
                          );
                }
              },
              ///02#:Second Function:
              builder: (context, state) {
                ///LoadingAddDeleteUpdatePostState:
                if (state is LoadingAddDeleteUpdatePostState)
                {
                  return const LoadingWidget();
                }
                return FormWidget(
                    isUpdatePost: isUpdatePost,
                    post: isUpdatePost ? post : null
                );
              },
            )),
      ),
    );
  }
}
