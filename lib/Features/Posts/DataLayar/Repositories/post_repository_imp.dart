import 'package:posts_app/Core/Exeptions/exeptions.dart';
import 'package:posts_app/Core/Network/network_connection.dart';
import 'package:posts_app/Features/Posts/DataLayar/DataSources/local_data_source.dart';
import 'package:posts_app/Features/Posts/DataLayar/DataSources/remote_data_source.dart';
import 'package:posts_app/Features/Posts/DataLayar/Models/post.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Core/Failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Repositories/posts_repository.dart';

class PostRepositoryImp extends PostRepository {
  final NetworkInfo networkInfo;
  final PostsRemoteDataSource postsRemoteDataSource;
  final PostsLocalDataSrc postsLocalDataSrc;

  PostRepositoryImp(
      {required this.networkInfo,
      required this.postsRemoteDataSource,
      required this.postsLocalDataSrc});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final posts = await postsRemoteDataSource.getAllPosts();
        postsLocalDataSrc.cachePosts(posts);
        return Right(posts);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final posts = await postsLocalDataSrc.getCachedPosts();
        return Right(posts);
      } on EmptyCachedData {
        return Left(EmptyCachedFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    if (await networkInfo.isConnected) {
      try {
        postsRemoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        postsRemoteDataSource.deletePost(id);
        return const Right(unit);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    if (await networkInfo.isConnected) {
      try {
        postsRemoteDataSource.updatePost(postModel);
        return const Right(unit);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
