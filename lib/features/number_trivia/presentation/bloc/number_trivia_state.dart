part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class NumberTriviaInitial extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Loaded extends NumberTriviaState {
  final NumberTriviaEntiteies trivia;

  const Loaded({required this.trivia});
  @override

  // TODO: implement props
  List<Object?> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
