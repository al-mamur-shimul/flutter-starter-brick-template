import 'package:get_it/get_it.dart';
import 'package:posts_app_with_test/posts/Ui/cubit/post_cubit.dart';
import 'package:posts_app_with_test/posts/data/repository/data_sources/post_remote_data_source.dart';
import 'package:posts_app_with_test/posts/data/repository/implementation/post_repository_impl.dart';
import 'package:posts_app_with_test/posts/domain/usecase/post_usecase.dart';

GetIt sl = GetIt.I;

Future<void> setUpServiceLocators() async{
  await sl.reset();
  sl
  ..registerFactory(PostRepositoryImpl.new)
  ..registerFactory(PostCubit.new)
  ..registerFactory(PostRemoteDataSourceImpl.new)
  ..registerFactory(PostUseCase.new);
}