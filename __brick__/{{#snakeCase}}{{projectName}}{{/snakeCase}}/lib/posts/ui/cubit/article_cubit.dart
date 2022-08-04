import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app_with_test/di/service_locator.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';
import 'package:posts_app_with_test/posts/domain/usecase/post_usecase.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());

  Future<void> fetchPosts() async {
    emit(ArticleLoading());
    final response = await sl<PostUseCase>().call('');

    response.fold(
          (postList) => emit(
        ArticleFetched(
          posts: postList,
        ),
      ),
          (errorMessage) => emit(
        ArticleError(message: errorMessage),
      ),
    );
  }
}
