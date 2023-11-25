import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled11/Core/Network/NetWorkInfo.dart';
import 'package:untitled11/Features/Post/Data/DataSourcs/PostLocalDataSource.dart';
import 'package:untitled11/Features/Post/Data/DataSourcs/PostRemoteDataSource.dart';
import 'package:untitled11/Features/Post/Data/Repositories/Post_repository_imp.dart';
import 'package:untitled11/Features/Post/Domain/Repositories/Post_Repositories.dart';
import 'package:untitled11/Features/Post/Domain/UseCases/AddPost.dart';
import 'package:untitled11/Features/Post/Domain/UseCases/UpdatePost.dart';
import 'package:untitled11/Features/Post/Domain/UseCases/delete_posts.dart';
import 'package:untitled11/Features/Post/Domain/UseCases/getAllPosts.dart';
import 'package:untitled11/Features/Post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:untitled11/Features/Post/presentation/bloc/post/post_bloc.dart';
import 'package:http/http.dart' as http;
///----------------------------------Start----------------------------------
var s1=GetIt.instance;

Future<void>init()async{
  /// !Features-of-posts
  //01#Bloc:
  s1.registerFactory(() => PostBloc(getAllPosts:s1()));
  s1.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: s1(),
      updatePost: s1(),
      deletePost: s1()
  ));

  //02#UseCase:
  s1.registerLazySingleton(()=>GetAllPostsUseCases(s1()));
  s1.registerLazySingleton(()=>AddPostUseCase(s1()));
  s1.registerLazySingleton(()=>UpdatePostUseCase(s1()));
  s1.registerLazySingleton(()=>DeletePostUseCase(s1()));

  //03#Repositories:
  s1.registerLazySingleton<PostRepository>(() =>
      PostRepositoryImpl(
          postRemoteDataSource: s1(),
          postLocalDataSource: s1(),
          netWorkInfo: s1()));

  //04:DataSource:
  s1.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImplWithHTTP(client: s1()));
  s1.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImplWithSharedPref(sharedPreferences: s1()));
  //05:Core:
  s1.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(connectionChecker: s1()));
  //06:External
  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  s1.registerLazySingleton(()=>sharedPreferences);
  s1.registerLazySingleton(() => http.Client());
  s1.registerLazySingleton(() => InternetConnectionChecker());
}
