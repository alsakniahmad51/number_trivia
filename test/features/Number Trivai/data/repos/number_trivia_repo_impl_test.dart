import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/core/error/failures.dart';
import 'package:numbers_trivia/core/network/network_info.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/data/repos/number_trivia_repo_impl.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

import 'number_trivia_repo_impl_test.mocks.dart';

// class MockNumberTriviaREmoteDataSource extends Mock implements NumberTriviaREmoteDataSource{}
// class MockNumberTriviaLocalDataSource extends Mock implements NumberTriviaLocalDataSource{}

@GenerateMocks([], customMocks: [
  MockSpec<NumberTriviaLocalDataSource>(
    as: #MockNumberTriviaLocalDataSource,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<NumberTriviaRemoteDataSource>(
    as: #MockNumberTriviaRemoteDataSource,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<NetworkInfo>(
    as: #MockNetWorkInfo,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late NumberTriviaRepoImpl repository;
  late MockNetWorkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNetworkInfo = MockNetWorkInfo();
    repository = NumberTriviaRepoImpl(
        numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
        numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isconnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isconnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('Get Concrete Number Trivia', () {
    const tNumber = 1;
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: tNumber);
    const NumberTriviaEntiteies tNumberTriviaEntity = tNumberTriviaModel;
    test('should check the device is online', () async {
      when(mockNetworkInfo.isconnected).thenAnswer((_) async => true);
      await repository.getConcreteNumberTrivia(tNumber);
      verify(mockNetworkInfo.isconnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source si successful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);
        // verify(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(
        //     tNumber)).called(1);
        // expect(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(tNumber)).called(1);

        expect(result, equals(const Right(tNumberTriviaEntity)));
      });
      test(
          'should cached the data locally   when the call to remote data source is successful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);
        // verify(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(
        //     tNumber)).called(1);
        // expect(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(tNumber)).called(1);
        verify(
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockNumberTriviaLocalDataSource
            .cachedNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verify(
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);

        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test(
          'should return Last locally when the call to remote data  is present',
          () async {
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });
      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  /*    *************************
  ******
  * *
  * *
  * *
  * *
  * */

  group('Get Random Number Trivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 123);
    const NumberTriviaEntiteies tNumberTriviaEntity = tNumberTriviaModel;
    test('should check the device is online', () async {
      when(mockNetworkInfo.isconnected).thenAnswer((_) async => true);
      await repository.getRandomNumberTrivia();
      verify(mockNetworkInfo.isconnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source si successful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        // verify(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(
        //     tNumber)).called(1);
        // expect(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(tNumber)).called(1);

        expect(result, equals(const Right(tNumberTriviaEntity)));
      });
      test(
          'should cached the data locally   when the call to remote data source si successful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        // verify(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(
        //     tNumber)).called(1);
        // expect(MockNumberTriviaRemoteDataSource().getConcreteNumberTrivia(tNumber)).called(1);
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        verify(mockNumberTriviaLocalDataSource
            .cachedNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        final result = await repository.getRandomNumberTrivia();
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);

        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test(
          'should return Last locally when the call to remote data  is present',
          () async {
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });
      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
