
import 'package:dartz/dartz.dart';
import 'package:untitled11/Features/Post/Domain/Repositories/Post_Repositories.dart';
import '../../../../Core/error/Failure.dart';

class DeletePostUseCase{
  final PostRepository repository;
  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await  repository.deletePost(postId);
  }
}