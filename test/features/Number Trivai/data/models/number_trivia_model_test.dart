import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

import '../../../../Fixtures/fixtures_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);

  test('should be subclass of entity', () {
    expect(tNumberTriviaModel, isA<NumberTriviaEntiteies>());
  });
  group('from-json', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonmap = jsonDecode(fixtures('trivia.json'));
      final result = NumberTriviaModel.fromjson(jsonmap);
      expect(result, tNumberTriviaModel);
    });
    test('should return a valid model when the JSON number is an double',
        () async {
      final Map<String, dynamic> jsonmap =
          jsonDecode(fixtures('trivia_double.json'));
      final result = NumberTriviaModel.fromjson(jsonmap);
      expect(result, tNumberTriviaModel);
    });
  });

  group('to-json', () {

    test('should return a JSON map the proper data', () async{
      final result = tNumberTriviaModel.toJson();

      final expectedMap = {
        "text": "test",
        "number": 1,
      };
      expect(result, expectedMap);


    });


  });
}
