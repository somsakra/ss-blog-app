import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ss_blog_app/core/use_cases/use_case.dart';
import 'package:ss_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ss_blog_app/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:ss_blog_app/features/blog/domain/usecase/upload_blog.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final response = await _uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    response.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final response = await _getAllBlogs(NoParams());
    response.fold(
          (l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
