import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Core/Messages/messages.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/add_post_usecase.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/delete_post_usecase.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/update_post_usecase.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPostUsecase;
  final DeletePostsUsecase deletePostsUsecase;
  final UpdatePostUsecase updatePostUsecase;

  AddDeleteUpdatePostBloc(
      {required this.addPostUsecase,
      required this.deletePostsUsecase,
      required this.updatePostUsecase})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPostUsecase(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState(
              message: _getFailureMessage(failure)));
        },
            (_) => emit(const SuccessAddDeleteUpdatePostState(
                message: ADD_POST_SUCCESSFULLY)));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePostUsecase(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState(
              message: _getFailureMessage(failure)));
        }, (_) {
          emit(const SuccessAddDeleteUpdatePostState(
              message: UPDATE_POST_SUCCESSFULLY));
        });
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePostsUsecase(event.postId);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState(
              message: _getFailureMessage(failure)));
        }, (_) {
          emit(const SuccessAddDeleteUpdatePostState(
              message: DELETE_POST_SUCCESSFULLY));
        });
      }
    });
  }

  String _getFailureMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    }
    if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      return "UnKnown Failure";
    }
  }
}
