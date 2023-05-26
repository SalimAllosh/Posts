import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/Core/Network/network_connection.dart';
import 'package:posts_app/Features/Posts/DataLayar/DataSources/local_data_source.dart';
import 'package:posts_app/Features/Posts/DataLayar/DataSources/remote_data_source.dart';
import 'package:posts_app/Features/Posts/DataLayar/Repositories/post_repository_imp.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Repositories/posts_repository.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/add_post_usecase.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/delete_post_usecase.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/get_all_posts_usecase.dart';
import 'package:posts_app/Features/Posts/DomainLayer/Usecases/update_post_usecase.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/AddDeleteUpdate/add_delete_update_post_bloc.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/GetPosts/posts_bloc.dart';
import 'package:posts_app/Features/Posts/PresentationLayar/Bloc/Toggle%20Theme/toggle_theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //-------------- Posts --------------------

  //bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUsecase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPostUsecase: sl(), deletePostsUsecase: sl(), updatePostUsecase: sl()));

  sl.registerFactory(() => ToggleThemeBloc());

  //usecases

  sl.registerLazySingleton(() => GetAllPostsUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => DeletePostsUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(postRepository: sl()));

  // repositoried

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImp(
      networkInfo: sl(), postsRemoteDataSource: sl(), postsLocalDataSrc: sl()));

  //datasources

  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceWithHttp(client: sl()));
  sl.registerLazySingleton<PostsLocalDataSrc>(
      () => PostLocalDataSrcWithSharedPreferences(sharedPreferences: sl()));

  // internet connection

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(internetConnectionChecker: sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
