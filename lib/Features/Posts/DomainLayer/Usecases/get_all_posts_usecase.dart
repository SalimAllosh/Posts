import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostRepository postRepository;

  GetAllPostsUsecase({required this.postRepository});

  Future<Either<Failure, List<Post>>> call() async {
    return postRepository.getAllPosts();
  }
}
