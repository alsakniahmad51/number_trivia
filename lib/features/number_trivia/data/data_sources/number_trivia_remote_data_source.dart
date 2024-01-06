import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:numbers_trivia/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaREmoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaREmoteDataSourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) =>
      _getNumberTriviaFromUrl('http://numbersapi.com/$number');
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaFromUrl('http://numbersapi.com/random');
  Future<NumberTriviaModel> _getNumberTriviaFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    const tNumberModel = NumberTriviaModel(text: 'test', number: 1);
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromjson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
