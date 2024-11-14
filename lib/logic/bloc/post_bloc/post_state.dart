part of 'post_bloc.dart';

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final String message;
  const PostState({
    this.status = PostStatus.loading,
    this.posts = const [],
    this.message = 'loading ...',
  });

  @override
  List<Object> get props => [
        status,
        posts,
        message,
      ];

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? message,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      message: message ?? this.message,
    );
  }
}
