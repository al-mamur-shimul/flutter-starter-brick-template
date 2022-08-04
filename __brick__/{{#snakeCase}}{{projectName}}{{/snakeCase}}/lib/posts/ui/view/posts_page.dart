import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_test/di/service_locator.dart';
import 'package:posts_app_with_test/posts/Ui/cubit/post_cubit.dart';
import 'package:posts_app_with_test/posts/Ui/widgets/post_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => sl<PostCubit>()..fetchPosts(),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostFetched) {
              return PostList(posts: state.posts ?? []);
            } else if (state is PostError) {
              return const Center(
                child: Text('something went wrong'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
