import 'package:fpdart/fpdart.dart';
import 'package:litlearn/core/error/kfailure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<KFailure, SuccessType>> call(Params params);
}
