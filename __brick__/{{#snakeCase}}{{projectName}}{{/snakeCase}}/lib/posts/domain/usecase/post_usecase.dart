import 'package:dartz/dartz.dart';
import 'package:posts_app_with_test/core/domain/usecase/base_usecase.dart';
import 'package:posts_app_with_test/di/service_locator.dart';
import 'package:posts_app_with_test/posts/data/repository/implementation/post_repository_impl.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';

class PostUseCase extends BaseUseCase<Either<List<Post>, String>, String?> {
  @override
  Future<Either<List<Post>, String>> call(String? input) async {
    return sl<PostRepositoryImpl>().fetchPost();
  }
}
