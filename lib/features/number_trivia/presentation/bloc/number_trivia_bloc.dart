import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/Util/input_converter.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia_entities.dart';
import 'package:numbers_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:numbers_trivia/features/number_trivia/domain/usecases/git_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaState get initialstate => Empty();

  final GetConcreteNumber12333Trivia concrete;
  final GetRandomNumberTrivia random;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.inputConverter,
      required this.random,
      required this.concrete})
      : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) {});
  }
}
