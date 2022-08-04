import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_app_with_test/posts/Ui/cubit/post_cubit.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';
import 'package:posts_app_with_test/posts/domain/usecase/post_usecase.dart';

class MockPostUseCase extends Mock implements PostUseCase {}

GetIt testSl = GetIt.I;

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
    expect(PostInitial(), testSl<PostCubit>().state);
  });

  group('post cubit test', () {
    blocTest<PostCubit, PostState>(
      'emits [loading, error] when post throws error',
      setUp: () async {
        await setupLocators();
        const Either<List<Post>, String> response = Right('oops');
        when(() => testSl<PostUseCase>().call(any()))
            .thenAnswer((_) async => Future.value(response));
      },
      build: () => testSl<PostCubit>(),
      act: (cubit) => cubit..fetchPosts(),
      wait: const Duration(seconds: 1),
      expect: () =>
          <PostState>[PostLoading(), const PostError(message: 'oops')],
      verify: (cubit) {
        verify(() => testSl<PostUseCase>().call(any())).called(1);
        expect(cubit.state, const PostError(message: 'oops'));
      },
    );

    blocTest<PostCubit, PostState>(
      'emits [loading, success] when post fetched',
      setUp: () async {
        await setupLocators();
        Either<List<Post>, String> response = Left(testOutputPostList);
        when(() => testSl<PostUseCase>().call(any()))
            .thenAnswer((_) async => Future.value(response));
      },
      build: () => testSl<PostCubit>(),
      act: (cubit) => cubit..fetchPosts(),
      wait: const Duration(seconds: 1),
      expect: () =>
          <PostState>[PostLoading(), PostFetched(posts: testOutputPostList)],
    );
  });
}

Future<void> setupLocators() async {
  await testSl.reset();
  testSl
    ..registerSingleton<PostUseCase>(MockPostUseCase())
    ..registerLazySingleton<PostCubit>(PostCubit.new);
}
