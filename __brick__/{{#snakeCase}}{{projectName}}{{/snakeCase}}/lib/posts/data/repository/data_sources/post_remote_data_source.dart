import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app_with_test/posts/data/dto/post_dto.dart';

abstract class PostRemoteDataSource {
  Future<Either<List<PostDto>, String>> fetchPost();
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final dio = Dio();

  @override
  Future<Either<List<PostDto>, String>> fetchPost() async {
    final response = await dio.get<String>(
      'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20',
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.data ?? '[]') as List;
      final list = body.map((dynamic json) {
        return PostDto(
          id: json['id'] as int,
          title: json['title'] as String,
          body: json['body'] as String,
        );
      }).toList();
      return left(list);
    }
    return right(response.statusMessage ?? '');
  }
}
