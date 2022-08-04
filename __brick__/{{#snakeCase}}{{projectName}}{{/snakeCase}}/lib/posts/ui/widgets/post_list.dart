import 'package:flutter/material.dart';
import 'package:posts_app_with_test/posts/Ui/widgets/post_item.dart';
import 'package:posts_app_with_test/posts/domain/entities/post.dart';

class PostList extends StatelessWidget {
  const PostList({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostListItem(post: posts[index]);
      },
    );
  }
}
