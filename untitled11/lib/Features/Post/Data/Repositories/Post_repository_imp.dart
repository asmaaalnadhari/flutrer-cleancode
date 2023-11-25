import 'package:dartz/dartz.dart';
import 'package:untitled11/Core/Network/NetWorkInfo.dart';
import 'package:untitled11/Core/error/Exception.dart';
import 'package:untitled11/Core/error/Failure.dart';
import 'package:untitled11/Features/Post/Data/DataSourcs/PostLocalDataSource.dart';
import 'package:untitled11/Features/Post/Data/DataSourcs/PostRemoteDataSource.dart';
import 'package:untitled11/Features/Post/Data/Model/PostModel.dart';
import 'package:untitled11/Features/Post/Domain/Entities/Post.dart';
import 'package:untitled11/Features/Post/Domain/Repositories/Post_Repositories.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostRepository{
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource  postLocalDataSource;
  final NetWorkInfo netWorkInfo;

  PostRepositoryImpl({required this.postRemoteDataSource, required this.postLocalDataSource, required this.netWorkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPost() async{
    if(await netWorkInfo.isConnected)
      {
        try{
          final remotePosts= await postRemoteDataSource.getAllPosts();
          postLocalDataSource.cachePosts(remotePosts);
          return Right(remotePosts);
        }on ServerException{
          return Left(ServerFailure());
        }

      }
    else{
      try{
        final localPosts=await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      }
      on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
   final PostModel postModel=PostModel( title: post.title, body: post.body);

   return await _getMessage(deleteOrUpdateOrAdd: () {
     return postRemoteDataSource.addPost(postModel);
   });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return await _getMessage(deleteOrUpdateOrAdd: () {
      return postRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);

    return await _getMessage(deleteOrUpdateOrAdd: () {
      return postRemoteDataSource.updatePost(postModel);
    });
  }

  //------------------------------------------------------
  Future<Either<Failure,Unit>>_getMessage(
  { required DeleteOrUpdateOrAddPost deleteOrUpdateOrAdd})async
  {
    if(await netWorkInfo.isConnected)
    {
      try{
        deleteOrUpdateOrAdd();
        return const Right(unit);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }
    else{
      return Left(OfflineFailure());
    }
  }
}

