import 'dart:convert';

import 'package:numbers_trivia/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cachedNumberTrivia(NumberTriviaModel triviatocache);
}

class NumberTriviaLocalDAtaSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDAtaSourceImpl(this.sharedPreferences);
  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
if( jsonString !=null){

    return Future.value(NumberTriviaModel.fromjson(jsonDecode(jsonString!)));
}else {
  throw CacheException();
}

  }

  @override
  Future<void> cachedNumberTrivia(NumberTriviaModel triviatocache) {
   return sharedPreferences.setString('CACHED_NUMBER_TRIVIA', jsonEncode(triviatocache.toJson()));
  }
}
