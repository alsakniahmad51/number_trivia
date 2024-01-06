import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/error/failures.dart';
import 'package:numbers_trivia/core/usecases/usecase.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

class GetRandomNumberTrivia implements Usecase<NumberTriviaEntiteies, NoParam> {
  NumberTriviaRepo numberTriviaRepo;
  GetRandomNumberTrivia(this.numberTriviaRepo);

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> call({NoParam? params}) async {
    // TODO: implement call
    return await numberTriviaRepo.getRandomNumberTrivia();
  }
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
