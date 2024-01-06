import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/error/failures.dart';
import 'package:numbers_trivia/core/usecases/usecase.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

class GetConcreteNumber12333Trivia
    implements Usecase<NumberTriviaEntiteies, Params> {
  final NumberTriviaRepo repository;

  GetConcreteNumber12333Trivia(this.repository);

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> call({Params? params}) async {
    return await repository.getConcreteNumberTrivia(params!.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
