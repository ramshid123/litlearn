import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseUpdateEnrolledVideoSeqCount
    implements Usecase<void, UseCaseUpdateEnrolledVideoSeqCountParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseUpdateEnrolledVideoSeqCount(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, void>> call(
      UseCaseUpdateEnrolledVideoSeqCountParams params) async {
    return await learningRemoteRepository.updateEnrolledVideoSeqCount(
        courseId: params.courseId, userId: params.userId);
  }
}

class UseCaseUpdateEnrolledVideoSeqCountParams {
  final String courseId;
  final String userId;

  UseCaseUpdateEnrolledVideoSeqCountParams(
      {required this.courseId, required this.userId});
}
