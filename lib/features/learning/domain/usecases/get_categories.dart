import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/entity/category_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetCategories
    implements Usecase<List<CategoryEntity>, UseCaseGetCategoriesParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetCategories(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, List<CategoryEntity>>> call(
      UseCaseGetCategoriesParams params) async {
    return await learningRemoteRepository.getCategories();
  }
}

class UseCaseGetCategoriesParams {}
