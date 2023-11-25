import 'package:dartz/dartz.dart';

import '../../../../Core/error/Failure.dart';
import '../Entities/Post.dart';
import '../Repositories/Post_Repositories.dart';

class AddPostUseCase{
  final PostRepository repository;
  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await  repository.addPost(post);
  }
}