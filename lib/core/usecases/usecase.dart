import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/failures.dart';

abstract class Usecase<Type, params> {
  Future<Either<Failure, Type>> call({params params});
}
