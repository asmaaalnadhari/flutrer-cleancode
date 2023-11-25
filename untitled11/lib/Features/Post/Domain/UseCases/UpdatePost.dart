
import 'package:dartz/dartz.dart';
import 'package:untitled11/Features/Post/Domain/Repositories/Post_Repositories.dart';
import '../../../../Core/error/Failure.dart';
import '../Entities/Post.dart';

class UpdatePostUseCase{
  final PostRepository repository;
  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await  repository.updatePost(post);
  }
}