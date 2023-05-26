import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Repositories/posts_repository.dart';

class DeletePostsUsecase {
  final PostRepository postRepository;

  DeletePostsUsecase({required this.postRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return postRepository.deletePost(postId);
  }
}
