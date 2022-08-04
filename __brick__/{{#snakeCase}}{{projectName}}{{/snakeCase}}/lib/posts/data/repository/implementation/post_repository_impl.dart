import 'package:dartz/dartz.dart';
import 'package:posts_app_with_test/di/service_locator.dart';
import 'package:posts_app_with_test/posts/data/repository/data_sources/post_remote_data_source.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';
import 'package:posts_app_with_test/posts/domain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<Either<List<Post>, String>> fetchPost() async {
    final response = await sl<PostRemoteDataSourceImpl>().fetchPost();
    return response.fold(
      (postDtoList) => Left(
        postDtoList
            .map(
              (element) => element.toEntity(),
            )
            .toList(),
      ),
      (errorMessage) => Right(errorMessage),
    );
  }
}
