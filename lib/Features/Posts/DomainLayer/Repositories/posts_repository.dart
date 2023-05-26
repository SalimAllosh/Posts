import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
