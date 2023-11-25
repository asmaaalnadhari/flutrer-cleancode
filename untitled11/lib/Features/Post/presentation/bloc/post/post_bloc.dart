import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled11/Core/String/failures.dart';
import 'package:untitled11/Core/error/Failure.dart';
import '../../../Domain/Entities/Post.dart';
import '../../../Domain/UseCases/getAllPosts.dart';
part 'post_event.dart';
part 'post_state.dart';
///################################################
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUseCases getAllPosts;
  PostBloc(  {required this.getAllPosts, }) : super(PostInitial()) {
    ///Main Function
    on<PostEvent>((event, emit) async{
      if(event is GetAllPostsEvent)
        {
          emit(LoadingPostsState());
          final failureOrPosts=await getAllPosts();
          emit(_mapFailureOrPostToState(failureOrPosts));
        }
    ///--------------------------------------------------
      else if(event is RefreshPostsEvent)
        {
          emit(LoadingPostsState());
          final failureOrPosts=await getAllPosts();
          emit(_mapFailureOrPostToState(failureOrPosts));
        }
    });
  }


///get==>FailureOrPosts:
PostState _mapFailureOrPostToState(Either<Failure, List<Post>> either)
  {
  return either.fold(
      (failure) {return ErrorPostsState(message: _mapFailureToMessage(failure));},
      (posts) {return LoadedPostsState(posts: posts);}
        );
  }
///get==>errorMessage:
  String _mapFailureToMessage(Failure failure)
  {
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return  "UnExpected Error,try again later..!";
    }
  }
}
