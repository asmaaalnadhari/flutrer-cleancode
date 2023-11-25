import 'package:dartz/dartz.dart';
import 'package:untitled11/Features/Post/Domain/Entities/Post.dart';
import '../../../../Core/error/Failure.dart';

abstract class PostRepository{
  Future<Either<Failure,List<Post>>> getAllPost();
  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> addPost(Post post);

}