import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/Core/Font%20Styles/font_styles.dart';
import 'package:posts_app/Core/Routes/app_route_constants.dart';
import 'package:posts_app/Core/Widgets/loading_widget.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/GetPosts/posts_bloc.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/Toggle%20Theme/toggle_theme_bloc.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Widgets/post_list.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(context),
      body: Center(child: _bodyBuilder()),
      floatingActionButton: _floatingActionBuilder(context),
    );
  }

  PreferredSizeWidget _appBarBuilder(context) {
    return AppBar(
      title: Center(
        child: Text(
          "Posts",
          style: AppTextStyles.displayMediumTextStyleGray,
        ),
      ),
      actions: [
        Switch(
          value: BlocProvider.of<ToggleThemeBloc>(context).toggle,
          onChanged: (value) {
            BlocProvider.of<ToggleThemeBloc>(context)
                .add(ToggleThemeClickedEvent());
            setState(() {});
          },
        )
      ],
    );
  }

  _bodyBuilder() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          //print(state.posts);
          return RefreshIndicator(
              onRefresh: () async {
                _refreshPage(context);
              },
              child: PostsList(postList: state.posts));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              _refreshPage(context);
            },
            child: Center(
              child: Text(
                "There are no posts saved, please go online",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _floatingActionBuilder(context) {
    return FloatingActionButton(
      onPressed: () {
        try {
          GoRouter.of(context).pushNamed(
              AppRouteConstants.ADD_UPDATE_POST_PAGE_NAME,
              params: {"route": "Add", "id": "0", "title": "0", "body": "0"});
        } catch (e) {
          print(e);
        }
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  _refreshPage(BuildContext context) async {
    return BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
  }
}
