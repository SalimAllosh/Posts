import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/Core/Routes/app_route_constants.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Pages/add_update_page.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Pages/posts_page.dart';

class AppRoute {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: AppRouteConstants.HOME_BAGE_NAME,
      path: AppRouteConstants.HOME_BAGE_PATH,
      pageBuilder: (context, state) => const MaterialPage(child: PostsPage()),
    ),
    GoRoute(
      name: AppRouteConstants.ADD_UPDATE_POST_PAGE_NAME,
      path:
          "${AppRouteConstants.ADD_UPDATE_POST_PAGE_PATH}/:route/:id/:title/:body",
      pageBuilder: (context, state) => MaterialPage(
        child: AddUpdatePostPage(
          page: state.params["route"]!,
          postId: int.parse(state.params["id"]!),
          postBody: state.params["body"],
          postTitle: state.params["title"],
        ),
      ),
    )
  ]);
}
