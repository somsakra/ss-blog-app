part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
          () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
// serviceLocator.registerFactory(() => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()));

//Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(serviceLocator()))
  //Repository
    ..registerFactory<AuthRepository>(
            () => AuthRepositoryImpl(serviceLocator(), serviceLocator()))
  //UseCases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
  //Bloc
    ..registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ));
}

void _initBlog() {
  //DataSource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
            () => BlogRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(
            () => BlogLocalDataSourceImpl(serviceLocator()))
  //Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
  //UseCases
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
  //Bloc
    ..registerLazySingleton(() =>
        BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()));
}
