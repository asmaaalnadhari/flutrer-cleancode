import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/Core/String/messages.dart';
import '../../../../../Core/String/failures.dart';
import '../../../../../Core/error/Failure.dart';
import '../../../Domain/Entities/Post.dart';
import '../../../Domain/UseCases/AddPost.dart';
import '../../../Domain/UseCases/UpdatePost.dart';
import '../../../Domain/UseCases/delete_posts.dart';
part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';
///============================================================
class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
//------------------------------
  AddDeleteUpdatePostBloc({
  required this.addPost,
  required this.updatePost,
  required this.deletePost
  })
//------------------------------
 : super(AddDeleteUpdatePostInitial()) {
    ///start:Main Function
    on<AddDeleteUpdatePostEvent>((event, emit) async{
    if(event is AddPostEvent)
      {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDone= await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(
            either: failureOrDone,
            message: ADD_SUCCESS_MESSAGE));
      }
   else if(event is UpdatePostEvent)
      {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDone= await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(
            either: failureOrDone,
            message: UPDATE_SUCCESS_MESSAGE));
      }
    else if(event is DeletePostEvent)
    {
      emit(LoadingAddDeleteUpdatePostState());
      final failureOrDone= await deletePost(event.postId);
      emit(_eitherDoneMessageOrErrorState(
          either: failureOrDone,
          message: DELETE_SUCCESS_MESSAGE));
    }
    }
      ///end:Main Function
    );
  }
  ///get===>Either(done,failure)
 AddDeleteUpdatePostState _eitherDoneMessageOrErrorState
  ({required Either<Failure, Unit> either,
   required String message})
 {
   return either.fold(
           (failure) => ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
           (_) => MessageAddDeleteUpdatePostState(message: message));
 }

  ///get===>errorMessage
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
