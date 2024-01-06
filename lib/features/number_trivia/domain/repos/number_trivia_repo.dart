import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/failures.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

abstract class NumberTriviaRepo {
  Future<Either<Failure, NumberTriviaEntiteies>> getConcreteNumberTrivia(
      int number);
  Future<Either<Failure, NumberTriviaEntiteies>> getRandomNumberTrivia();
}
