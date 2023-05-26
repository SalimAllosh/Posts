import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Core/Messages/messages.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;

  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUsecase();

        failureOrPosts.fold((failure) {
          emit(ErrorPostsState(message: _getFailureMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUsecase();

        failureOrPosts.fold((failure) {
          emit(ErrorPostsState(message: _getFailureMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      }
    });
  }

  String _getFailureMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    }
    if (failure is EmptyCachedFailure) {
      return EMPTY_CACHED_FAILURE_MESSAGE;
    }
    if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      return "UnKnown Failure";
    }
  }
}
