import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/core/Util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  group('String To Unsigned Integer', () {
    test('should convert string to int ', () {
      const str = '123';

      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, const Right(123));
    });
    test('should throw exception when the String is not integer ', () {
      const str = 'abc';

      final result = inputConverter.stringToUnsignedInt(str);



      expect(result, Left(InvalidInputFailure()));
    });



  });
}
