import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';

class PostModel extends Post {
  const PostModel(
      {required super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> postjson) {
    return PostModel(
        id: postjson['id'], title: postjson['title'], body: postjson['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
