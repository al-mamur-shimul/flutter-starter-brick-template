import 'package:posts_app_with_test/posts/domain/entities/post.dart';

class PostDto {
  PostDto({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) => PostDto(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  int? userId;
  int? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  Post toEntity() => Post(id: id ?? 0, title: title ?? '', body: body ?? '');
}
