import 'package:flutter/cupertino.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';

class NumberTriviaModel extends NumberTriviaEntiteies{
  final int number;
  final String text;

 const NumberTriviaModel( {required this.text,required this.number}) : super(number:number,text: text);
factory NumberTriviaModel.fromjson(Map<String,dynamic> json){

  return NumberTriviaModel(text: json['text'], number: (json['number']as num).toInt());

}


Map<String ,dynamic> toJson(){
  return {
    'text' :text,
    'number' :number

  };
}

}