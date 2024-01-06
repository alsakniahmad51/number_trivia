import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/core/error/failures.dart';
import 'package:numbers_trivia/core/network/network_info.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repos/number_trivia_repo.dart';

typedef _ConcreteOrRandomChoose = Future<NumberTriviaEntiteies> Function();

class NumberTriviaRepoImpl implements NumberTriviaRepo {
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepoImpl(
      {required this.numberTriviaRemoteDataSource,
      required this.numberTriviaLocalDataSource,
      required this.networkInfo});

  Future<Either<Failure, NumberTriviaEntiteies>> _getTrivia(
      _ConcreteOrRandomChoose getConcreteOrRandom) async {
    networkInfo.isconnected;
    if (await networkInfo.isconnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();

        numberTriviaLocalDataSource
            .cachedNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia =
            await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(() {
      return numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTriviaEntiteies>> getRandomNumberTrivia() async {
    return _getTrivia(() {
      return numberTriviaRemoteDataSource.getRandomNumberTrivia();
    });
  }
}
