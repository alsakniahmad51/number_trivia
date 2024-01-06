import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../Fixtures/fixtures_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NumberTriviaREmoteDataSourceImpl datasource;
  setUp(() {
    mockClient = MockClient();
    datasource = NumberTriviaREmoteDataSourceImpl(client: mockClient);
  });
  group('get Concrete Number Trivia', () {
    const tNumber = 1;
    final tNumberModel = NumberTriviaModel(text: 'test', number: 1);
    test('should return', () {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));
//'http://numbersapi.com/$tNumber' as Uri?client.
      datasource.getConcreteNumberTrivia(tNumber);
      verify(mockClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return with status code 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));
//'http://numbersapi.com/$tNumber' as Uri?client.
      final result = await datasource.getConcreteNumberTrivia(tNumber);
      expect(result, tNumberModel);
    });

    test('should throw exception when status code !=200 ', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('something was wrong', 404));
//'http://numbersapi.com/$tNumber' as Uri?client.
      final call = datasource.getConcreteNumberTrivia;
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get Random Number Trivia', () {
    final tNumberModel = NumberTriviaModel(text: 'test', number: 1);
    test('should return', () {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));
//'http://numbersapi.com/$tNumber' as Uri?client.
      datasource.getRandomNumberTrivia();
      verify(mockClient.get(Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return with status code 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));
//'http://numbersapi.com/$tNumber' as Uri?client.
      final result = await datasource.getRandomNumberTrivia();
      expect(result, tNumberModel);
    });

    test('should throw exception when status code !=200 ', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('something was wrong', 404));
//'http://numbersapi.com/$tNumber' as Uri?client.
      final call = datasource.getRandomNumberTrivia;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
