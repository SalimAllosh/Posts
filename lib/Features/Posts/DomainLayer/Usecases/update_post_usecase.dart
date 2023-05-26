import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Repositories/posts_repository.dart';

class UpdatePostUsecase {
  final PostRepository postRepository;

  UpdatePostUsecase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return postRepository.updatePost(post);
  }
}
