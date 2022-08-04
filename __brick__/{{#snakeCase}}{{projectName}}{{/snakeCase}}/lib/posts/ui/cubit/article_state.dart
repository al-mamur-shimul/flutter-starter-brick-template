part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleFetched extends ArticleState {
  const ArticleFetched({this.posts});

  final List<Post>? posts;

  @override
  List<Object> get props => [posts ?? []];
}

class ArticleError extends ArticleState {
  const ArticleError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
