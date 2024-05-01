import 'package:fpdart/src/either.dart';
import 'package:ss_blog_app/core/error/failures.dart';
import 'package:ss_blog_app/core/use_cases/use_case.dart';
import 'package:ss_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ss_blog_app/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return blogRepository.getAllBlogs();
  }
}
