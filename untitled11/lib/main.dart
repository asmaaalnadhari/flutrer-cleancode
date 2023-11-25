import 'package:flutter/material.dart';
import 'package:untitled11/Core/app_theme.dart';
import 'package:untitled11/Features/Post/presentation/Pages/posts_page.dart';
import 'package:untitled11/Features/Post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:untitled11/Features/Post/presentation/bloc/post/post_bloc.dart';
import 'injection_container.dart'as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await di.init();
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create:(_)=>di.s1<PostBloc>()..add(GetAllPostsEvent()) ),
          BlocProvider(create:(_)=>di.s1<AddDeleteUpdatePostBloc>() ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          title: 'Posts App',
          home: const PostsPage(),
        ));
  }
}

