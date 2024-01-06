import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:numbers_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Fixtures/fixtures_reader.dart';
import 'number_trivia_local_datasource_test.mocks.dart';

// @GenerateMocks([SharedPreferences])

@GenerateMocks([], customMocks: [
  MockSpec<SharedPreferences>(
    as: #MockSharedPreferences,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDAtaSourceImpl datasource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLocalDAtaSourceImpl(mockSharedPreferences);
  });
  group('number trivia local data source', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromjson(jsonDecode(fixtures('trivia_cached.json')));

    test(
        'should  return NumberTrivia from shared Preferences when there is one in the cache ',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixtures('trivia_cached.json'));

      final result = await datasource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));

      expect(result, tNumberTriviaModel);
    });

    test('should  throw Cache Exception when there is not a cached value  ',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = datasource.getLastNumberTrivia;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache number trivia', () {
    const tNumberTriviaModel = NumberTriviaModel(text: 'test text', number: 1);
    test('should call  the shared preferences to cache the data ', () {
      datasource.cachedNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

      verify(mockSharedPreferences.setString(
          'CACHED_NUMBER_TRIVIA', expectedJsonString));
    });
  });
}
/*
*
* */
