import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/Core/APIs/api_url.dart';
import 'package:posts_app/Core/Exeptions/exeptions.dart';
import 'package:posts_app/Features/Posts/DataLayar/Models/post.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> updatePost(PostModel post);
  Future<Unit> addPost(PostModel post);
  Future<Unit> deletePost(int postId);
}

class PostsRemoteDataSourceWithHttp extends PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceWithHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BASE_URL + GET_POSTS_END_POINT),
        headers: REQUEST_HEADER);
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postmodels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postmodels;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {'title': post.title, 'body': post.body};

    final response =
        await client.post(Uri.parse(BASE_URL + ADD_POST_END_POINT), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(BASE_URL + DELETE_POST_END_POINT + postId.toString()),
        headers: REQUEST_HEADER);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id;
    final body = {'title': post.title, 'body': post.body};

    final response = await client.patch(
        Uri.parse(BASE_URL + UPDATE_POST_END_POINT + postId.toString()),
        body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }
}
