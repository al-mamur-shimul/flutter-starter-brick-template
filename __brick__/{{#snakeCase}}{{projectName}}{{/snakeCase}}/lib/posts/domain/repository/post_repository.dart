import 'package:dartz/dartz.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<List<Post>, String>> fetchPost();
}
