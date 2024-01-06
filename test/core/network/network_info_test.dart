import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockDataConnectionChecker mockdataconnectionchecker;

  setUp(() {
    mockdataconnectionchecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockdataconnectionchecker);
  });
  group('test network', () {
    test('is connection', () async {
      when(mockdataconnectionchecker.hasConnection)
          .thenAnswer((_) async => true);
      final result = await networkInfoImpl.isconnected;
      verify(mockdataconnectionchecker.hasConnection);
      expect(result, true);
    });
  });
}
