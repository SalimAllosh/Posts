// ignore_for_file: unused_element, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posts_app/Core/Font%20Styles/font_styles.dart';
import 'package:posts_app/Core/Routes/app_route_constants.dart';
import 'package:posts_app/Core/Widgets/loading_widget.dart';
import 'package:posts_app/Core/Widgets/show_snack_bar.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Entities/post_entity.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/AddDeleteUpdate/add_delete_update_post_bloc.dart';

class AddUpdatePostPage extends StatefulWidget {
  final String page;
  int? postId;
  String? postTitle;
  String? postBody;

  AddUpdatePostPage(
      {required this.page,
      required this.postId,
      required this.postTitle,
      required this.postBody,
      super.key});

  @override
  State<AddUpdatePostPage> createState() => _AddUpdatePostPageState();
}

class _AddUpdatePostPageState extends State<AddUpdatePostPage> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  FocusNode titleFoucsNode = FocusNode();
  FocusNode bodyFoucsNode = FocusNode();
  FocusNode buttonFocusNode = FocusNode();

  Post post = const Post(id: 0, title: "", body: "");

  bool isUpdate = false;

  @override
  void initState() {
    super.initState();

    if (widget.page == "Add") {
    } else {
      isUpdate = true;
      titleController.text = widget.postTitle!;
      bodyController.text = widget.postBody!;
    }
  }

  @override
  void dispose() {
    titleFoucsNode.dispose();
    bodyFoucsNode.dispose();
    buttonFocusNode.dispose();
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "${widget.page} Post",
        style: AppTextStyles.displayMediumTextStyleGray,
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is SuccessAddDeleteUpdatePostState) {
              ShowSnakBar.showSuccessSnakBar(
                  message: state.message, context: context);
              GoRouter.of(context).pushNamed(AppRouteConstants.HOME_BAGE_NAME);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              ShowSnakBar.showErrorSnakBar(
                  message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }
            return _form(formKey, context, titleController, titleFoucsNode,
                bodyFoucsNode, bodyController, buttonFocusNode, isUpdate, post);
          },
        ),
      ),
    );
  }

  Form _form(
    GlobalKey<FormState> formKey,
    BuildContext context,
    TextEditingController titleController,
    FocusNode titleFoucsNode,
    FocusNode bodyFoucsNode,
    TextEditingController bodyController,
    FocusNode buttonFocusNode,
    bool isUpdate,
    Post post,
  ) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: textFormFieldSmall(context, titleController,
                        titleFoucsNode, bodyFoucsNode),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textFormField(
                      context, bodyController, bodyFoucsNode, buttonFocusNode),
                ],
              ),
              ElevatedButton(
                  focusNode: buttonFocusNode,
                  onPressed: () async {
                    _addOrUpdatePost(post);
                  },
                  child: Text(
                    widget.page,
                    style: AppTextStyles.displayMediumTextStyleGray,
                  )),
              isUpdate
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Theme.of(context).colorScheme.error)),
                      focusNode: buttonFocusNode,
                      onPressed: () async {
                        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
                            .add(DeletePostEvent(postId: post.id));
                      },
                      child: Text(
                        "Delete",
                        style: AppTextStyles.displayMediumTextStyleGray,
                      ))
                  : Container(),
            ]),
      ),
    );
  }

  TextFormField textFormFieldSmall(
      BuildContext context,
      TextEditingController titleController,
      FocusNode titleFoucsNode,
      FocusNode bodyFoucsNode) {
    return TextFormField(
      style: Theme.of(context).textTheme.displayMedium,
      keyboardType: TextInputType.text,
      controller: titleController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        label: const Text("Title"),
        labelStyle: Theme.of(context).textTheme.displayMedium,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5), gapPadding: 8),
      ),
      focusNode: titleFoucsNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(bodyFoucsNode);
      },
    );
  }

  TextFormField textFormField(
      BuildContext context,
      TextEditingController bodyController,
      FocusNode bodyFoucsNode,
      FocusNode buttonFocusNode) {
    return TextFormField(
      style: Theme.of(context).textTheme.displayMedium,
      maxLength: 300,
      maxLines: 5,
      decoration: InputDecoration(
          label: const Text("body"),
          labelStyle: Theme.of(context).textTheme.displayMedium,
          prefixIcon: const Icon(Icons.description_outlined),
          floatingLabelStyle: Theme.of(context).textTheme.displayMedium,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      keyboardType: TextInputType.multiline,
      controller: bodyController,
      focusNode: bodyFoucsNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(buttonFocusNode);
      },
    );
  }

  void _addOrUpdatePost(Post post) {
    if (isUpdate) {
      BlocProvider.of<AddDeleteUpdatePostBloc>(context, listen: false)
          .add(UpdatePostEvent(post: post));
    } else {
      BlocProvider.of<AddDeleteUpdatePostBloc>(context, listen: false)
          .add(AddPostEvent(post: post));
    }
  }
}
