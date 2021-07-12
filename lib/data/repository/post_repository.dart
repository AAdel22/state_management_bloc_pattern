import 'dart:convert';

import 'package:http/http.dart';
import 'package:state_management_bloc_pattern/data/model/post.dart';

abstract class PostRepository {
  Future<List<Post>> get getAllPosts;
}

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<Post>> getAllPosts async {
    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((item) => Post.fromJson(item)).toList();
    }else {
      throw Exception("Cannot Load Posts");
    }
  }
}
