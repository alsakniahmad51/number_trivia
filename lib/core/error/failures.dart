import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];


}
// ignore: must_be_immutable
class ServerFailure extends Failure{}
// ignore: must_be_immutable
class CacheFailure extends Failure{}