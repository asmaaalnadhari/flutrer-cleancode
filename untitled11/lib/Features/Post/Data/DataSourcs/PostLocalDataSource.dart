import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled11/Core/error/Exception.dart';
import '../Model/PostModel.dart';
///===================================================
const CACHED_POSTS="CACHED_POSTS";
abstract class PostLocalDataSource{
  Future<List<PostModel>>getCachedPosts();
  Future<Unit>cachePosts(List<PostModel> postModels );
}
///===================================================

class PostLocalDataSourceImplWithSharedPref extends PostLocalDataSource{
  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImplWithSharedPref({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson=postModels.map(
    (postModels){postModels.toJson();}).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final  jsonString=sharedPreferences.getString(CACHED_POSTS);
    if(jsonString !=null)
      {
        List decodeJsonData =json.decode(jsonString);
        List<PostModel> jsonToPostModels=decodeJsonData.map<PostModel>
          ((jsonPostModel) =>PostModel.fromJson(jsonPostModel)).toList();
        return Future.value(jsonToPostModels);
      }
    else{
      throw EmptyCacheException();
    }
  }
  
}