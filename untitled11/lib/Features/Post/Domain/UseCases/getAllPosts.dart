import 'package:dartz/dartz.dart';
import 'package:untitled11/Features/Post/Domain/Repositories/Post_Repositories.dart';

import '../../../../Core/error/Failure.dart';
import '../Entities/Post.dart';

class GetAllPostsUseCases{
  final PostRepository repository;
  GetAllPostsUseCases(this.repository);

  Future<Either<Failure,List<Post>>> call()async{
    return await repository.getAllPost();
  }

}