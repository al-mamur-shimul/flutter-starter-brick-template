part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostState {
  const PostFetched({this.posts});

  final List<Post>? posts;

  @override
  List<Object> get props => [posts ?? []];
}

class PostError extends PostState {
  const PostError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
