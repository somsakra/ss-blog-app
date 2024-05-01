import 'package:fpdart/src/either.dart';
import 'package:ss_blog_app/core/entities/user.dart';
import 'package:ss_blog_app/core/error/failures.dart';
import 'package:ss_blog_app/core/use_cases/use_case.dart';
import 'package:ss_blog_app/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
