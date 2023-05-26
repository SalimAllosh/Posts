import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/Exeptions/exeptions.dart';
import 'package:posts_app/Features/Posts/DataLayar/Models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSrc {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDataSrcWithSharedPreferences extends PostsLocalDataSrc {
  final SharedPreferences sharedPreferences;

  PostLocalDataSrcWithSharedPreferences({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List modelPostToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString("CACHED_POSTS", jsonEncode(modelPostToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final postsString = sharedPreferences.getString("CACHED_POSTS");
    if (postsString != null) {
      List decodedJsontData = json.decode(postsString);

      List<PostModel> jsonDataToPostModel = decodedJsontData
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();

      return Future.value(jsonDataToPostModel);
    } else {
      throw EmptyCachedData();
    }
  }
}
