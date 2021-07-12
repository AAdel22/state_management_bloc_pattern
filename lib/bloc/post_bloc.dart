import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management_bloc_pattern/data/model/post.dart';
import 'package:state_management_bloc_pattern/data/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  PostBloc(this.repository) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is FetchPost) {
      yield PostLoading();
      try {
        final posts = await repository.getAllPosts;
        yield PostLoaded(posts);
      } catch (e) {
        yield PostErorr(e.toString());
      }
    }
  }
}
