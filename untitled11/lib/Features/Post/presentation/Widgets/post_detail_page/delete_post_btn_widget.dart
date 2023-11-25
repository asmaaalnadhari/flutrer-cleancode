import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/app_theme.dart';
import '../../../../../Core/util/snackbar_message.dart';
import '../../../../../Core/widgets/loading_widget.dart';
import '../../Pages/posts_page.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'delete_dialog_widget.dart';
//==========================================================================
class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  ///Main Method:
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
          side:const BorderSide(
            color: secondaryColor,
            width: 2,
          )
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline,color: secondaryColor,),
      label: const Text("Delete",style:TextStyle(color: secondaryColor) ,),
    );
  }
  ///deleteDialog:
  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            ///01#First Method:
            listener: (context, state) {
              ///MessageAddDeleteUpdatePostState:
              if (state is MessageAddDeleteUpdatePostState)
              {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message,
                    context: context
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage(),),
                        (route) => false);
              }
              ///ErrorAddDeleteUpdatePostState:
              else if (state is ErrorAddDeleteUpdatePostState)
              {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message,
                    context: context);
              }
            },
            ///02#Second Method:
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
