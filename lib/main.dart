import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/Core/Routes/app_routes_configuration.dart';
import 'package:posts_app/Core/Theme/app_theme.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/Toggle%20Theme/toggle_theme_bloc.dart';
import 'Core/DependencyInjection/injection_container.dart' as di;
import 'Features/Posts/PresentationLayar/Bloc/AddDeleteUpdate/add_delete_update_post_bloc.dart';
import 'Features/Posts/PresentationLayar/Bloc/GetPosts/posts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(BlocProvider(
    create: (_) => di.sl<ToggleThemeBloc>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<AddDeleteUpdatePostBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: BlocProvider.of<ToggleThemeBloc>(context, listen: true).toggle
            ? AppThemes.light
            : AppThemes.dark,
        themeMode: ThemeMode.system,
        routerDelegate: AppRoute().router.routerDelegate,
        routeInformationParser: AppRoute().router.routeInformationParser,
        routeInformationProvider: AppRoute().router.routeInformationProvider,
      ),
    );
  }
}
