import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/Core/Routes/app_route_constants.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';

class PostsList extends StatefulWidget {
  final List<Post> postList;

  const PostsList({super.key, required this.postList});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(
                  AppRouteConstants.ADD_UPDATE_POST_PAGE_NAME,
                  params: {
                    "route": "Update",
                    "id": widget.postList[index].id.toString(),
                    "title": widget.postList[index].title,
                    "body": widget.postList[index].body
                  });
            },
            child: ListTile(
              title: Text(
                widget.postList[index].title.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text(widget.postList[index].body.toString(),
                  style: Theme.of(context).textTheme.displaySmall),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: widget.postList.length);
  }
}
