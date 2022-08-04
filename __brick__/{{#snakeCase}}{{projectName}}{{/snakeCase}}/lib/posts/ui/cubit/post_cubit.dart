import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';
import 'package:posts_app_with_test/posts/domain/usecase/post_usecase.dart';

import '../../../di/service_locator.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  Future<void> fetchPosts() async {
    emit(PostLoading());
    final response = await sl<PostUseCase>().call('');

    response.fold(
      (postList) => emit(
        PostFetched(
          posts: postList,
        ),
      ),
      (errorMessage) => emit(
        PostError(message: errorMessage),
      ),
    );
  }
}
