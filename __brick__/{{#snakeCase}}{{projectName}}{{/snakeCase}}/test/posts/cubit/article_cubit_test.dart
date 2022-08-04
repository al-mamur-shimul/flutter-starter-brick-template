import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';
import 'package:posts_app_with_test/posts/domain/usecase/post_usecase.dart';
import 'package:posts_app_with_test/posts/ui/cubit/article_cubit.dart';

import 'article_cubit_test.mocks.dart';

class TestPostUseCase extends Mock implements PostUseCase {}

GetIt testSl = GetIt.I;

@GenerateMocks([TestPostUseCase])
void main() {
  late List<Post> testOutputPostList;
  setUpAll(() {
    testOutputPostList = [
      const Post(
        id: 1,
        title: 'lorem ipsum',
        body: 'lorem ipsum, lorem ipsum',
      )
    ];
    setupLocators();
  });

  test('test initial state of post cubit', () {
    expect(ArticleInitial(), testSl<ArticleCubit>().state);
  });

  group('post cubit test', () {
    blocTest<ArticleCubit, ArticleState>(
      'emits [loading, error] when post throws error',
      setUp: () async {
        await setupLocators();
        const Either<List<Post>, String> response = Right('oops');
        when(testSl<PostUseCase>().call(any))
            .thenAnswer((_) async => Future.value(response));
      },
      build: () => testSl<ArticleCubit>(),
      act: (cubit) => cubit..fetchPosts(),
      wait: const Duration(seconds: 1),
      expect: () =>
          <ArticleState>[ArticleLoading(), const ArticleError(message: 'oops')],
    );

    blocTest<ArticleCubit, ArticleState>(
      'emits [loading, success] when post fetched',
      setUp: () async {
        await setupLocators();
        final Either<List<Post>, String> response = Left(testOutputPostList);
        when(testSl<PostUseCase>().call(any))
            .thenAnswer((_) async => Future.value(response));
      },
      build: () => testSl<ArticleCubit>(),
      act: (cubit) => cubit..fetchPosts(),
      wait: const Duration(seconds: 1),
      expect: () => <ArticleState>[
        ArticleLoading(),
        ArticleFetched(posts: testOutputPostList),
      ],
    );
  });
}

Future<void> setupLocators() async {
  await testSl.reset();
  testSl
    ..registerSingleton<PostUseCase>(MockTestPostUseCase())
    ..registerLazySingleton<ArticleCubit>(ArticleCubit.new);
}
