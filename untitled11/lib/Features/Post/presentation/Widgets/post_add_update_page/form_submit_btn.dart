import 'package:flutter/material.dart';
import '../../../../../Core/app_theme.dart';
//===========================================
class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
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
        onPressed: onPressed,
        icon: isUpdatePost ? const Icon(Icons.edit) : const Icon(Icons.add),
        label: Text(isUpdatePost ? "Update" : "Add"));
  }
}
