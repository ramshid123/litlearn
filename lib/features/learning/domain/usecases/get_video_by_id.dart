import 'package:fpdart/src/either.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/core/error/kfailure.dart';
import 'package:litlearn/core/usecase/usecase.dart';
import 'package:litlearn/features/learning/domain/repository/remote_repository.dart';

class UseCaseGetVideoById
    implements Usecase<VideoEntity, UseCaseGetVideoByIdParams> {
  final LearningRemoteRepository learningRemoteRepository;

  UseCaseGetVideoById(this.learningRemoteRepository);

  @override
  Future<Either<KFailure, VideoEntity>> call(
      UseCaseGetVideoByIdParams params) async {
    return await learningRemoteRepository.getVideoById(params.videoId);
  }
}

class UseCaseGetVideoByIdParams {
  final String videoId;

  UseCaseGetVideoByIdParams(this.videoId);
}
